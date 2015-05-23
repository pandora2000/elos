shared_examples 'publisher' do
  let(:field_value) { SecureRandom.uuid }
  let(:field_value2) { SecureRandom.uuid }
  let(:repo_entry) { described_class.create(field => field_value) }
  let(:entry_id) { repo_entry.id }

  describe '.publish_reindex' do
    it 'should reindex subscribers' do
      if repo_entry.is_a?(ActiveRecord::Base)
        repo_entry.update_column(field, field_value2)
      elsif repo_entry.is_a?(Elos::Repository::Adapter::Elos)
        repo_entry.send("#{field}=", field_value2)
        repo_entry.send(:_save, callback: false)
      else
        expect(true).to eq false
      end
      described_class.publish_reindex
      expect(described_class.subscribers.first.find(entry_id).send(field)).to eq field_value2
    end
  end
end
