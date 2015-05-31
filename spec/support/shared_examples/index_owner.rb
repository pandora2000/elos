shared_examples 'index owner' do
  describe '.index_name' do
    it 'should be derived from class name' do
      described_class.index_name.start_with?(described_class.name.underscore)
    end
  end
end
