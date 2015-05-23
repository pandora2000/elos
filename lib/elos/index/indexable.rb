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
      if !unindex && data = index_data.(obj)
        data.merge!(_destroyed: destroy)
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
  end
end
