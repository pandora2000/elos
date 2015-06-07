class Elos::Index::Attributes::KeysGuesser
  def self.guess(given_mappings)
    %i(id) + given_mappings[:properties].keys
  end
end
