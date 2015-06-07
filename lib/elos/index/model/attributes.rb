module Elos::Index::Model::Attributes
  extend ActiveSupport::Concern

  def attributes
    Hash[self.class.attribute_keys.map { |k| [k, send(k)] }]
  end
end
