describe Elos::Index::Attributes do
  let(:repo_class) { create_repo_class { |t| t.string :title } }
  let(:index_class) do
    create_index_class do

      subscribe o.repo_class

      query_builder Elos::QueryBuilder::Builtin::MatchAllQueryBuilder

      field :title, :string

      index_data ->(obj) do
        { title: obj.title, json: { description: obj.description } }
      end
    end
  end

  describe '.attributes' do
    it 'should derived from mappings' do
      expect(index_class.attribute_keys).to eq %i(id title)
    end
  end
end
