describe Elos::Index::Attributes do
  describe '.attributes' do
    it 'should derived from mappings' do
      expect(AEntry.attribute_keys).to eq %i(id title)
    end
  end
end
