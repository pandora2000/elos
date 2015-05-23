module Elos::Index::Unindexable
  extend ActiveSupport::Concern

  class_methods do
    def unindex
      initialize_for_reindex(true)
    end
  end
end
