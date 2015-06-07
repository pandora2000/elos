module Elos::Index::Model::Initializable
  extend ActiveSupport::Concern

  included do
    define_model_callbacks :new
  end

  def initialize(attrs = {})
    @_data = Elos::Index::Model::Object.new
    @_attrs = attrs
    run_callbacks :new
  end
end
