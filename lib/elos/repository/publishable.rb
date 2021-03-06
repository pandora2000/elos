module Elos::Repository::Publishable
  extend ActiveSupport::Concern

  included do
    cattr_accessor :subscribers

    self.subscribers = []

    proc = -> { after_save ->(obj) { subscribers.each { |s| s.index(obj) } } }
    if respond_to?(:after_save)
      proc.()
    else
      self.included_callbacks << proc
    end
  end

  def publish_reindex
    self.class.subscribers.each do |klass|
      klass.index(self)
    end
  end

  class_methods do
    def publish_reindex
      scan(&:publish_reindex)
    end
  end
end
