module Elos::Repository::Adapter::Elos::Migratable
  extend ActiveSupport::Concern

  class_methods do
    def migrate
      reindex do |old_index_name, new_index_name|
        _scan(index_name: old_index_name) do |hit|
          client.update(index: new_index_name, type: type_name, id: hit['_id'], body: { doc: {}, upsert: hit['_source'] })
        end
      end
    end
  end
end
