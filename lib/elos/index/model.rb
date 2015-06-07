module Elos::Index::Model
  extend ActiveSupport::Concern

  included do
    include ActiveModel::Model
    include ActiveModel::Callbacks

    include Elos::Index::Model::Initializable
    include Elos::Index::Model::Attributes
    include Elos::Index::Model::Assignable
    include Elos::Index::Model::Identifiable
  end
end
