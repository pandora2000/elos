module Elos::Index
  extend ActiveSupport::Concern

  included do
    include Elos::Index::Core
    include Elos::Index::Registration
    include Elos::Index::Properties
    include Elos::Index::Mappings
    include Elos::Index::RawHelpers
    include Elos::Index::Refreshable
    include Elos::Index::Indexable
    include Elos::Index::Reindexable
    include Elos::Index::Unindexable
    include Elos::Index::Searchable
    include Elos::Index::Locatable
    include Elos::Index::Subscribable
    include Elos::Index::Attributes
    include Elos::Index::Model
  end
end
