module Elos::Index::Searchable
  extend ActiveSupport::Concern

  included do
    cattr_accessor :query_builder_class
  end

  class_methods do
    def query_builder(klass)
      self.query_builder_class = klass
    end

    def search(query_builder_class: self.query_builder_class, **params)
      Elos::Criteria.new(params: params, query_builder_class: query_builder_class, klass: self)
    end
  end
end
