module Elos::Index::Attributes
  extend ActiveSupport::Concern

  included do
    cattr_accessor :attributes
  end
end
