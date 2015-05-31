module Elos::Index::Properties
  extend ActiveSupport::Concern

  class_methods do
    def array_property(value_type)
      {
        properties: {
          value: send("#{value_type}_property")
        }
      }
    end

    def string_property
      { type: 'string', index: 'not_analyzed' }
    end

    def integer_property
      { type: 'integer' }
    end

    def long_property
      { type: 'long' }
    end

    def boolean_property
      { type: 'boolean' }
    end
  end
end
