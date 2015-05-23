module Elos::Index::Locatable
  extend ActiveSupport::Concern

  class_methods do
    def where(params = {})
      search(query_builder_class: Elos::QueryBuilder::Builtin::WhereQueryBuilder, **params)
    end

    def find(arg)
      if arg.is_a?(Array)
        where(id: arg).to_a!
      else
        where(id: [arg]).first!
      end
    end
  end
end
