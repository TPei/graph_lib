require './lib/vertex.rb'
require 'json'

class Graph
  def initialize
    @vertices = []
  end

  def add_vertex(name)
    vertex = Vertex.new(name)
    @vertices << vertex
    vertex
  end

  def add_edge(from, to)
    names = @vertices.map(&:name)
    #return false unless names.include?(from) && names.include?(to)
    @vertices[names.index(from)].add_child(to)
    @vertices[names.index(to)].add_parent(from)
    nil
  end

  def children_for(vertex)
    names = @vertices.map(&:name)
    children_names = @vertices[names.index(vertex)].children
    children = children_names.collect do |child|
      @vertices[names.index(child)]
    end
    children
  end

  def parents_for(vertex)
    names = @vertices.map(&:name)
    parent_names = @vertices[names.index(vertex)].parents
    parents = parent_names.collect do |parent|
      @vertices[names.index(parent)]
    end
    parents
  end

  def self.from_hash(hash)
    g = Graph.new
    hash['vertices'].each do |vertex|
      g.add_vertex(vertex)
    end

    hash['edges'].each do |from, to|
      g.add_edge(from, to)
    end
    return g
  end

  def self.from_file(filename)
    self.from_hash(JSON.parse(File.read(filename)))
  end
end
