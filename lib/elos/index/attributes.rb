module Elos::Index::Attributes
  extend ActiveSupport::Concern

  included do
    cattr_accessor :set_attribute_keys
  end

  class_methods do
    def attribute_keys
      self.set_attribute_keys ||= KeysGuesser.guess(given_mappings)
    end
  end
end
