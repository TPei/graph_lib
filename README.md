# GraphLib

A very minimal graph organization library in Ruby.

Allows you to add vertices and edges and know about parents and
children.

```ruby
require './graph.rb'

g = Graph.new
g.add_vertex("a")
g.add_vertex("b")
g.add_vertex("c")

g.add_edge("a", "b")
g.add_edge("a", "c")
g.add_edge("b", "c")

g.children_for("a") # => [Vertex<b>, Vertex<c>]
g.parents_for("c") # => [Vertex<a>, Vertex<b>]
```

If you try to add an edge between nodes that don't exist, you get an
error...

You can also generate a graph directly from a json document like this:

```json
{
  "vertices": ["a", "b", "c", "d"],
  "edges": [
    ["a", "b"],
    ["a", "c"],
    ["b", "d"],
    ["c", "d"]
  ]
}
```

Do this by either calling `Graph.from_hash(graph_hash)` or
`Graph.from_file('graph.json')`.

## Now what?

Dunno, do graph stuff, like traverse a graph and collect all nodes lying
between a node and the root node:

```ruby
g = Graph.from_hash({
  'vertices' => ['G', 'M', 'D', 'TP', 'E', 'P', 'SO', 'SU'],
  'edges' => [
    ['G', 'M'],
    ['M', 'D'],
    ['M', 'TP'],
    ['D', 'E'],
    ['D', 'P'],
    ['TP', 'E'],
    ['TP', 'P'],
    ['E', 'SO'],
    ['E', 'SU'],
    ['P', 'SO'],
    ['P', 'SU']
  ]
})

# find all nodes on the way to the root for a given node in the graph
# assumes transitive reduction has been applied on DAG
start = g.get_vertex('P')

nodes = [start]

continue = true
n = 0

while(continue) do
  nodes |= g.parents_for(nodes[n].name)
  n += 1
  continue = false if n >= nodes.length
end

puts nodes.map(&:name)
puts "steps: #{n}"
```
