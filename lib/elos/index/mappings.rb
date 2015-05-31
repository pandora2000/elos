module Elos::Index::Mappings
  extend ActiveSupport::Concern

  included do
    cattr_writer :mappings
  end

  class_methods do
    def mappings(mappings = nil)
      if mappings
        set_mappings(mappings)
      else
        self.class_variable_get(:@@mappings)
      end
    end

    protected

    def set_mappings(mappings)
      mps = mappings.is_a?(Proc) ? mappings.() : mappings.deep_dup
      mps[:properties].merge!(_destroyed: boolean_property, json: no_index_string_property)
      self.mappings = { type_name => mps }
    end
  end
end
