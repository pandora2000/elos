module Elos::Index::Model::Attributes
  extend ActiveSupport::Concern

  def attributes
    Hash[self.class.attributes.map { |k| [k, send(k)] }]
  end
end
