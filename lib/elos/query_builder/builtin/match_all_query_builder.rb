class Elos::QueryBuilder::Builtin::MatchAllQueryBuilder < Elos::QueryBuilder::Base
  def build
    match_all_query
  end
end
