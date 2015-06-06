module Elos::Index::Registration
  extend ActiveSupport::Concern

  included do
    Elos.index_classes << self
  end
end
