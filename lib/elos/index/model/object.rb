class Elos::Index::Model::Object
  attr_reader :object

  def self.encode(object)
    inner_encode(object).to_json
  end

  def initialize(params = {})
    @params = params
    @object = objectify(params)
  end

  def method_missing(method, *args, **hargs, &block)
    if method.to_s.end_with?('=')
      object.send(method, objectify(args[0]))
    elsif object.respond_to?(method)
      object.send(method, *args)
    else
      super
    end
  end

  protected

  def self.inner_encode(object)
    if object.is_a?(Hash)
      object.each do |k, v|
        object[k] = inner_encode(v)
      end
    elsif object.is_a?(Array)
      object.each_with_index do |o, i|
        object[i] = inner_encode(o)
      end
    elsif object.is_a?(Elos::Index)
      object.attributes.merge!(type: object.class.name)
    else
      object
    end
  end

  def objectify(value)
    if value.is_a?(Hash)
      if value.key?(:type)
        value.delete(:type).constantize.new(value)
      else
        OpenStruct.new(Hash[value.map { |k, v| [k, objectify(v)] }])
      end
    elsif value.is_a?(Array)
      value.map { |v| objectify(v) }
    else
      value
    end
  end
end
