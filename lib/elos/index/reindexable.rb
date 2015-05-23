module Elos::Index::Reindexable
  extend ActiveSupport::Concern

  included do
    cattr_accessor :read_alias_name, :write_alias_name, :reindex_block

    self.read_alias_name = "#{index_name}read"
    self.write_alias_name = "#{index_name}write"
  end

  class_methods do
    def initialize_for_reindex(force = false)
      return false if !force && client.indices.exists_alias(name: read_alias_name) && client.indices.exists_alias(name: write_alias_name)
      Elos::Lock.unlock(lock_key) if force
      delete_index("#{index_name}*")
      index_name = random_index_name
      unless client.indices.exists(index: index_name)
        client.indices.create(index: index_name, body: index_parameters)
        alias_index(read_alias_name, index_name)
        alias_index(write_alias_name, index_name)
        return true
      end
      false
    end

    def reindex(set_block = nil, &block)
      return set_reindex(set_block) if set_block
      proc = block || self.reindex_block
      long_args = proc.parameters.length == 2
      Elos::Lock.lock(lock_key) do
        initialize_for_reindex
        old_index_name = read_index_name
        unless write_index_names == [old_index_name]
          repair_for_reindex
        end
        return unless new_index_name = create_index_with_random_name
        begin
          alias_index(write_alias_name, new_index_name)
          if long_args
            proc.(old_index_name, new_index_name)
          else
            proc.()
          end
          switch_pointed_index(read_alias_name, old_index_name, new_index_name)
          unalias_index(write_alias_name, old_index_name)
        rescue Exception => e
          if read_index_name == old_index_name
            if write_index_names.include?(new_index_name)
              unalias_index(write_alias_name, new_index_name)
            end
            delete_index(new_index_name)
          end
          raise e
        end
        delete_index(old_index_name)
      end
    end

    protected

    def read_index_name
      aliased_index_name(read_alias_name)
    end

    def write_index_name
      write_index_names.first
    end

    def write_index_names
      aliased_index_names(write_alias_name)
    end

    def lock_key
      "elos:reindex_or_migrate:#{name.underscore}"
    end

    def set_reindex(block)
      self.reindex_block = block
    end

    def repair_for_reindex
      (write_index_names - [read_index_name]).each do |name|
        unalias_index(write_alias_name, name)
        delete_index(name)
      end
      return if write_index_name == read_index_name
      alias_index(write_alias_name, read_index_name)
    end

    def aliased_index_name(alias_name)
      aliased_index_names(alias_name).first
    end

    def aliased_index_names(alias_name)
      client.indices.get_alias(index: "#{index_name}*", name: alias_name).keys
    end

    def alias_index(alias_name, index_name)
      client.indices.update_aliases body: {
        actions: [
          { add: { index: index_name, alias: alias_name } }
        ]
      }
    end

    def unalias_index(alias_name, index_name)
      client.indices.update_aliases body: {
        actions: [
          { remove: { index: index_name, alias: alias_name } }
        ]
      }
    end

    def switch_pointed_index(alias_name, from_index_name, to_index_name)
      client.indices.update_aliases body: {
        actions: [
          { remove: { index: from_index_name, alias: alias_name } },
          { add: { index: to_index_name, alias: alias_name } }
        ]
      }
    end

    def create_index_with_random_name
      create_index(name = random_index_name)
      name
    end

    def random_index_name
      "#{index_name}#{SecureRandom.uuid}"
    end
  end
end
