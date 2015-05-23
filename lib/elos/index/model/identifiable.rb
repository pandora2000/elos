module Elos::Index::Model::Identifiable
  extend ActiveSupport::Concern

  included do
    attr_accessor :id

    before_new -> { self.id = @_attrs.delete(:id) }
  end
end
