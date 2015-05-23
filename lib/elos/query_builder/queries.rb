module Elos::QueryBuilder::Queries
  extend ActiveSupport::Concern

  def ids_query(key = :id, value = nil)
    { query: { ids: { values: value || params[key] } } }
  end

  def match_query(key, value)
    { query: { match: { key => { query: value, operator: 'and' } } } }
  end

  def match_all_query
    { query: { match_all: {} } }
  end
end
