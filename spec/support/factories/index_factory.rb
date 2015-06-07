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
    klass = Class.new do
      include Elos::Index
    end
    klass.class_eval(&block)
    const_name = "Random#{SecureRandom.random_number(10000)}"
    Object.const_set(const_name, klass)
    @@classes ||= []
    @@classes << klass
    klass
  end
end

RSpec.configure do |config|
  config.include SpecIndexFactory
end
