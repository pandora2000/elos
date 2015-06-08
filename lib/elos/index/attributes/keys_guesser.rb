class Elos::Index::Attributes::KeysGuesser
  def self.guess(given_mappings, mappings_fields)
    %i(id) + (given_mappings.try(:[], :properties) || {}).merge(mappings_fields || {}).keys
  end
end
