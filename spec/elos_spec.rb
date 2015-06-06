require 'spec_helper'

describe Elos do
  it 'has a version number' do
    expect(Elos::VERSION).not_to be nil
  end

  describe '.index_classes' do
    it 'should be set' do
      expect(Elos.index_classes).to include(Entry)
    end
  end

  describe '.reindex' do
    it 'should call each reindex of index classes' do
      Elos.index_classes.each do |klass|
        expect(klass).to receive(:reindex)
      end
      Elos.reindex
    end
  end

  describe '.unindex' do
    it 'should call each unindex of index classes' do
      Elos.index_classes.each do |klass|
        expect(klass).to receive(:unindex)
      end
      Elos.unindex
    end
  end
end
