class Elos::Result
  include Enumerable

  def initialize(result)
    @result = result
  end

  def each
    result.each do |item|
      yield item
    end
  end

  def pluck(key)
    map { |obj| obj.send(key) }
  end

  protected

  def result
    @result
  end
end
