describe Elos::Index::Attributes do
  let(:repo_class) { create_repo_class { |t| t.string :title } }
  let(:index_class) do
    create_index_class do

  subscribe o.repo_class

  mappings -> do
    {
      _all: { enabled: false },
      properties: { title: { type: 'string' } }
    }
  end

  index_data ->(obj) do
    { title: obj.title, json: { description: obj.description } }
  end

  query_builder Elos::QueryBuilder::Builtin::MatchAllQueryBuilder
    end
  end

  describe '.attributes' do
    it 'should derived from mappings' do
      expect(index_class.attribute_keys).to eq %i(id title)
    end
  end
end
