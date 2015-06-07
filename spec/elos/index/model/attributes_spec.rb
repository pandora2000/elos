describe Elos::Index::Model::Attributes do
  describe '#attributes' do
    let(:repo) { AEntryRepo.create(title: SecureRandom.uuid) }

    it 'should return hash including id and title' do
      expect(AEntry.find(repo.id).attributes).to include(id: repo.id.to_s, title: repo.title)
    end
  end
end
