module Elos::Repository::Adapter::Elos::Model::Reindexable
  extend ActiveSupport::Concern

  included do
    reindex -> do
      scan do |obj|
        obj.reindex
      end
    end
  end

  def reindex(destroy: false)
    self.class.index(self, destroy: destroy)
  end
end
