module SpecRepoFactory
  extend ActiveSupport::Concern

  included do
    after do
      @@classes ||= []
      next if @@classes.empty?
      m = ActiveRecord::Migration.new
      m.verbose = false
      @@classes.each do |klass|
        m.drop_table klass.name.underscore
      end
      @@classes = []
    end
  end

  def create_repo_class(&block)
    m = ActiveRecord::Migration.new
    m.verbose = false
    klass = Class.new(ActiveRecord::Base)
    const_name = "Random#{SecureRandom.random_number(10000)}"
    Object.const_set(const_name, klass)
    klass.include Elos::Repository::Adapter::ActiveRecord
    m.create_table(klass.name.underscore, &block)
    @@classes ||= []
    @@classes << klass
    klass
  end
end

RSpec.configure do |config|
  config.include SpecRepoFactory
end
