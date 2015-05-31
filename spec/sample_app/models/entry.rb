class Entry
  include Elos::Repository::Adapter::Elos

  mappings -> do
    {
      _all: { enabled: false },
      properties: { title: { type: 'string' } }
    }
  end

  index_data ->(obj) do
    { title: obj.title }
  end

  query_builder Elos::QueryBuilder::Builtin::MatchAllQueryBuilder
end
