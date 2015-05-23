class EEntryRepo
  include Elos::Repository::Adapter::Elos

  mappings({
    type_name => {
      _all: { enabled: false },
      properties: { title: { type: 'string' } }
    }
  })

  index_data ->(obj) do
    { title: obj.title }
  end
end
