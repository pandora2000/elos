module Elos::Repository::Adapter::Elos::Model::Unindexable
  extend ActiveSupport::Concern

  def unindex
    self.class.index(obj, unindex: true)
  end
end
