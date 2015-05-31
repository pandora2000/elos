require_relative '../repositories/e_entry_repo'

class EEntry
  include Elos::Index

  subscribe EEntryRepo

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
