require './lib/graph.rb'

RSpec.describe Graph do
  before do
    @graph = Graph.new
  end

  describe '#add_vertex' do
    it 'creates and adds a new vertex' do
      expect(Vertex).to receive(:new).with('a')
      @graph.add_vertex('a')
    end
  end

  describe '#add_edge' do
    it 'creates a new edge between two existing vertices' do
      a = @graph.add_vertex('a')
      b = @graph.add_vertex('b')
      expect(a).to receive(:add_child).with('b')
      expect(b).to receive(:add_parent).with('a')
      @graph.add_edge('a', 'b')
    end
  end

  describe '#children_for' do
    it 'returns an array of all children of a node' do
      a = @graph.add_vertex('a')
      b = @graph.add_vertex('b')
      c = @graph.add_vertex('c')
      @graph.add_edge('a', 'b')
      @graph.add_edge('a', 'c')
      expect(@graph.children_for('a')).to match_array [b, c]
    end
  end

  describe '#parents_for' do
    it 'returns an array of all parents of a node' do
      a = @graph.add_vertex('a')
      b = @graph.add_vertex('b')
      @graph.add_edge('a', 'b')
      expect(@graph.parents_for('b')).to match_array [a]
    end
  end

  describe '.from_hash' do
    it 'creates a graph according to a hash spec' do
      hash = {
        'vertices' => ['a', 'b', 'c', 'd'],
        'edges' => [
          ['a', 'b'],
          ['a', 'c'],
          ['b', 'd'],
          ['c', 'd']
        ]
      }

      graph = Graph.from_hash(hash)
      expect(graph.children_for('a').map(&:name)).to match_array ['b', 'c']
      expect(graph.parents_for('d').map(&:name)).to match_array ['b', 'c']
    end
  end

  describe '.from_file' do
    it 'creates a graph according to a hash spec' do
      graph = Graph.from_file('./spec/graph.json')
      expect(graph.children_for('a').map(&:name)).to match_array ['b', 'c']
      expect(graph.parents_for('d').map(&:name)).to match_array ['b', 'c']
    end
  end
end
