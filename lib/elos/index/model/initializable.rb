module Elos::Index::Model::Initializable
  extend ActiveSupport::Concern

  included do
    define_model_callbacks :new
  end

  def initialize(attrs = {})
    @_data = Elos::DataObject.new
    @_attrs = attrs.merge(items: [{ hoge: 'hoge' }])
    run_callbacks :new
  end
end
