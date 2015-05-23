module Elos::Configuration
  extend ActiveSupport::Concern

  included do
    cattr_accessor :client, :env, :settings
  end

  class_methods do
    def config(host: nil, env: nil, settings: {})
      host ||= 'localhost:9200'
      self.client = ::Elasticsearch::Client.new(host: host)
      self.env = env
      self.settings = settings
    end
  end
end
