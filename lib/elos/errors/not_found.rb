class Elos::Errors::NotFound < StandardError
  def initialize
    super('Not found.')
  end
end
