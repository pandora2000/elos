module Elos::Repository::Adapter::Elos
  extend ActiveSupport::Concern

  include Elos::Index

  included do
    cattr_accessor :included_callbacks

    self.included_callbacks = []

    include Elos::Repository::Adapter::Elos::Migratable
    include Elos::Repository::Adapter::Elos::Scanable
    include Elos::Repository::Publishable
    include Elos::Repository::Adapter::Elos::Model::Reindexable
    include Elos::Repository::Adapter::Elos::Model::Unindexable
    include Elos::Repository::Adapter::Elos::Model::Persistable
    include Elos::Repository::Adapter::Elos::Model::Destroyable
    include Elos::Repository::Adapter::Elos::Model::Validatable

    included_callbacks.each { |callback| callback.() }

    subscribe self

    physically_destroy false
  end

  def self.reindex_all(indices = nil)
    # indices ||= 結びつく全てのindexたち
    # indicesのreindex全てをnestさせてその中でscanしてreindexしていく
  end
end
