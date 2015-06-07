module Elos::Index::Attributes
  extend ActiveSupport::Concern

  included do
    cattr_accessor :attribute_keys
  end
end
