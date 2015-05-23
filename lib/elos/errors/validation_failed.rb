class Elos::Errors::ValidationFailed < StandardError
  def initialize
    super('Validation failed.')
  end
end
