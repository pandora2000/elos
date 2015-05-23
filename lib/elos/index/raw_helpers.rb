module Elos::Index::RawHelpers
  extend ActiveSupport::Concern

  class_methods do
    def raw_get(id)
      client.get(index: read_alias_name, type: type_name, id: id)
    end
  end
end
