require_relative '../repositories/a_entry_repo'

class AEntry
  include Elos::Index

  subscribe AEntryRepo

  mappings({
    type_name => {
      _all: { enabled: false },
      properties: { title: { type: 'string' } }
    }
  })

  index_data ->(obj) do
    { title: obj.title }
  end

  query_builder Elos::QueryBuilder::Builtin::MatchAllQueryBuilder
end
