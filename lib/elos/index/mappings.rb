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
      mps = mappings.deep_dup
      mps[type_name][:properties].merge!(_destroyed: { type: 'boolean' })
      self.mappings = mps
    end
  end
end
