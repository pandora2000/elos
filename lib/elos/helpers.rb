module Elos::Helpers
  extend ActiveSupport::Concern

  included do
    cattr_accessor :index_classes

    self.index_classes = []
  end

  class_methods do
    def reindex
      index_classes.each { |klass| klass.reindex }
    end

    def unindex
      index_classes.each { |klass| klass.unindex }
    end
  end
end
