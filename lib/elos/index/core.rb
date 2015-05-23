module Elos::Index::Core
  extend ActiveSupport::Concern

  included do
    cattr_accessor :client, :type_name, :index_name

    self.client = Elos.client
    self.type_name = name.underscore.gsub('/', '-')
    self.index_name = "#{name.underscore.pluralize.gsub('/', '-')}=#{Elos.env}="
  end

  class_methods do
    protected

    def create_index(name)
      unless client.indices.exists(index: name)
        client.indices.create(index: name, body: index_parameters)
      end
    end

    def delete_index(name)
      if client.indices.exists(index: name)
        client.indices.delete(index: name)
      end
    end

    def refresh_index(name)
      client.indices.refresh(index: name)
    end

    def index_parameters
      { settings: Elos.settings, mappings: mappings }
    end
  end
end
