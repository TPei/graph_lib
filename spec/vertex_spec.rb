require './lib/vertex.rb'

RSpec.describe Vertex do
  before do
    @vertex = Vertex.new('some node')
  end

  describe '#add_child' do
    it 'adds a child to the children array' do
      @vertex.add_child('a')
      expect(@vertex.children).to eq ['a']
    end
  end

  describe '#add_parent' do
    it 'adds a parent to the parents array' do
      @vertex.add_parent('a')
      expect(@vertex.parents).to eq ['a']
    end
  end

  describe '#root?' do
    context 'when no parents present' do
      it 'returns true' do
        expect(@vertex.root?).to eq true
      end
    end

    context 'when parents present' do
      it 'returns false' do
        @vertex.add_parent('a')
        expect(@vertex.root?).to eq false
      end
    end
  end
end
