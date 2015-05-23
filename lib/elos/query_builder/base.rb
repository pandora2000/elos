class Elos::QueryBuilder::Base
  include Elos::QueryBuilder::Filters
  include Elos::QueryBuilder::Queries

  def initialize(params)
    @params = params
  end

  def _build
    query = build
    original_query = query[:query]
    filter = term_filter(:_destroyed, value: false)
    query[:query] = { filtered: { query: original_query, filter: filter } }
    # puts JSON.pretty_generate(query)
    query
  end

  protected

  def params
    @params
  end
end
