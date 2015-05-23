class Elos::DataObject
  attr_reader :object

  def initialize(params = {})
    @params = params
    @object = objectify(params)
  end

  def method_missing(method, *args, **hargs, &block)
    if object.respond_to?(method)
      object.send(method, *args)
    elsif method.to_s.end_with?('=')
      object.send(method, *args)
    else
      super
    end
  end

  protected

  def objectify(value)
    if value.is_a?(Hash)
      OpenStruct.new(Hash[value.map { |k, v| [k, objectify(v)] }])
    elsif value.is_a?(Array)
      value.map { |v| objectify(v) }
    else
      value
    end
  end
end
