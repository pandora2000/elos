module Elos::Index::Refreshable
  extend ActiveSupport::Concern

  class_methods do
    def refresh
      refresh_index(read_alias_name)
    end
  end
end
