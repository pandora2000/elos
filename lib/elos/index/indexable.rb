module Elos::Index::Indexable
  extend ActiveSupport::Concern

  included do
    cattr_writer :index_data
  end

  class_methods do
    def index_data(index_data = nil)
      if index_data
        self.index_data = index_data
      else
        self.class_variable_get(:@@index_data)
      end
    end

    def index(obj, destroy: false, unindex: false)
      if !unindex && data = wrap_index_data(obj, destroy)
        params = { index: write_alias_name, type: type_name, body: data }
        params.merge!(id: obj.id) if obj.id
        client.index(params)['_id']
      else
        begin
          client.delete(index: write_alias_name, type: type_name, id: obj.id)
          nil
        rescue Elasticsearch::Transport::Transport::Errors::NotFound
        end
      end
    end

    private

    def wrap_index_data(obj, destroy)
      data = index_data.(obj)
      return unless data
      data.merge!(_destroyed: destroy)
      data[:json] = Elos::Index::Model::Object.encode(data[:json]) if data[:json]
      data
    end
  end
end
