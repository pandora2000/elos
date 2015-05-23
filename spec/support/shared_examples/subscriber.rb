shared_examples 'subscriber' do
  let(:field_value) { SecureRandom.uuid }
  let(:repo_entry) { described_class.repository_class.create(field => field_value) }
  let(:entry_id) { repo_entry.id }

  describe '.index_name' do
    it 'should be derived from class name' do
      described_class.index_name.start_with?(described_class.name.underscore)
    end
  end

  describe '.find' do
    it 'should find entry' do
      expect { described_class.find(entry_id) }.not_to raise_error
    end

    describe 'found entry' do
      let(:entry) { described_class.find(entry_id) }

      it 'should have same id' do
        expect(entry.id).to eq repo_entry.id.to_s
      end

      it 'should have same title' do
        expect(entry.send(field)).to eq repo_entry.send(field)
      end
    end
  end
end
