module SpecIndexFactory
  extend ActiveSupport::Concern

  included do
    after do
      @@classes ||= []
      next if @@classes.empty?
      @@classes.each do |klass|
        klass.unindex
      end
      @@classes = []
    end
  end

  def create_index_class(&block)
    klass = Class.new
    const_name = "Random#{SecureRandom.random_number(10000)}"
    Object.const_set(const_name, klass)
    klass.include Elos::Index
    _self = self
    klass.class_eval do
      cattr_accessor :outer

      self.outer = _self

      def self.o
        outer
      end
    end
    klass.class_eval(&block)
    @@classes ||= []
    @@classes << klass
    klass
  end
end

RSpec.configure do |config|
  config.include SpecIndexFactory
end
