module Elos::Index::Properties
  extend ActiveSupport::Concern

  class_methods do
    def boolean_property
      { type: 'boolean' }
    end
  end
end
