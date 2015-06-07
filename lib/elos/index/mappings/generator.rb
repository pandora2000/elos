class Elos::Index::Mappings::Generator
  include Elos::Index::Properties

  def self.generate(mappings, fields:, physically_destroyable:, type_name:)
    fields ||= {}
    mappings = mappings.deep_dup
    mappings[:_all] = { enabled: false } unless mappings[:_all]
    properties = mappings[:properties]
    properties[:_destroyed] = boolean_property unless physically_destroyable
    properties[:json] = no_index_string_property
    properties.reverse_merge!(fields)
    { type_name => mappings }
  end
end
