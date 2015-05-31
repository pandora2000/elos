describe EEntry do
  it_behaves_like 'index owner'

  describe '#title' do
    let(:field) { :title }

    it_behaves_like 'subscriber'
  end
end
