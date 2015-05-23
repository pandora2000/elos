describe Entry do
  let(:field) { :title }
  let(:title) { SecureRandom.uuid }
  let(:title2) { SecureRandom.uuid }
  let(:entry) { Entry.new(title: title) }

  # it_behaves_like 'publisher'

  describe '.index_name' do
    it 'should be derived from class name' do
      described_class.index_name.start_with?(described_class.name.underscore)
    end
  end

  describe '.new' do
    it 'should not persist entry' do
      expect(entry).not_to be_persisted
    end

    it 'should not make any entry searchable' do
      expect(Entry.search.total_count).to eq 0
    end
  end

  describe '#save' do
    before { entry.save }

    context 'when not persisted' do
      it 'should persist entry' do
        expect(entry).to be_persisted
      end

      it 'should set entry id' do
        expect(entry.id).not_to be_nil
      end

      it 'should make entry findable' do
        expect { Entry.find(entry.id) }.not_to raise_error
      end

      it 'should not make any other entry searchable' do
        expect(Entry.search.total_count).to eq 1
      end
    end

    context 'when persisted' do
      let(:save) { entry.title = title2; entry.save }

      it 'should update entry title' do
        save
        expect(Entry.find(entry.id).title).to eq title2
      end

      it 'should not change entry id' do
        expect { save }.not_to change { entry.id }
      end

      it 'should not make any other entry searchable' do
        save
        expect(Entry.search.total_count).to eq 1
      end
    end
  end

  describe '#destroy' do
    before { entry.save; entry.destroy }

    it 'should destroy entry' do
      expect(entry).to be_destroyed
    end

    it 'should make entry unfindable' do
      expect { Entry.find(entry.id) }.to raise_error
    end

    it 'should not phisically destroy entry' do
      expect { Entry.raw_get(entry.id) }.not_to raise_error
    end
  end

  describe '#title=' do
    let(:entry) { Entry.new }

    it 'should set title' do
      entry.title = title
      expect(entry.title).to eq title
    end

    context 'after title set' do
      before { entry.title = title }

      it 'should set title' do
        entry.title = title2
        expect(entry.title).to eq title2
      end
    end
  end
end
