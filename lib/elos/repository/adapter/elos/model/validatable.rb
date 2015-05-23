module Elos::Repository::Adapter::Elos::Model::Validatable
  extend ActiveSupport::Concern

  def validate!
    return true if valid?
    raise Elos::Errors::ValidationFailed.new
  end
end
