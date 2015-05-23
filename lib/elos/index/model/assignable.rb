module Elos::Index::Model::Assignable
  extend ActiveSupport::Concern

  included do
    after_new -> { assign_attributes(@_attrs) }
  end

  def assign_attributes(attrs)
    attrs.each do |key, value|
      @_data.send("#{key}=", value)
    end
  end

  def method_missing(method, *args)
    @_data.send(method, *args)
  rescue NoMethodError
    super
  end
end
