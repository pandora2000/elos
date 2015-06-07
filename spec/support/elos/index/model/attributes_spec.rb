describe Elos::Index::Model::Attributes do
  describe '.attributes' do
    it 'should derived from mappings' do
      expect(AEntry.attributes).to eq %i(id title)
    end
  end
end
