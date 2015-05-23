module Elos::Index::Subscribable
  extend ActiveSupport::Concern

  included do
    cattr_accessor :repository_class
  end

  class_methods do
    def subscribe(repository_class)
      self.repository_class = repository_class
      repository_class.subscribers << self
    end
  end
end
