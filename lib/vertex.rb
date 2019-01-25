class Vertex
  def initialize(name)
    @name = name
    @children = []
    @parents = []
  end

  def add_child(name)
    @children << name
  end

  def add_parent(name)
    @parents << name
  end

  def name
    @name
  end

  def children
    @children
  end

  def parents
    @parents
  end

  def root?
    @parents.empty?
  end
end
