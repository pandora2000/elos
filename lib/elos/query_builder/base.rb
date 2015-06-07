class Elos::QueryBuilder::Base
  include Elos::QueryBuilder::Filters
  include Elos::QueryBuilder::Queries

  def initialize(params)
    @klass = params.delete(:class)
    @params = params
  end

  def wrap_build
    query = build
    return query if !@klass.respond_to?(:physically_destroy?) || @klass.physically_destroy?
    original_query = query[:query]
    filter = term_filter(:_destroyed, value: false)
    query[:query] = { filtered: { query: original_query, filter: filter } }
    # puts JSON.pretty_generate(query)
    query
  end

  protected

  attr_reader :params
end
