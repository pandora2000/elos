module Elos::Index::Mappings
  extend ActiveSupport::Concern

  included do
    cattr_accessor :given_mappings, :set_mappings, :mappings_fields
  end

  class_methods do
    def field(name, type)
      self.mappings_fields ||= {}
      mappings_fields[name] = send("#{type}_property")
    end

    def mappings(mappings = nil)
      return self.given_mappings = mappings.is_a?(Proc) ? mappings.() : mappings.deep_dup if mappings
      self.set_mappings ||= Generator.generate(given_mappings, fields: mappings_fields, type_name: type_name, physically_destroyable: respond_to?(:physically_destroy?) && physically_destroy?)
    end
  end
end
