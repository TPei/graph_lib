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
g.add_vertex("d")

g.add_edge("a", "b")
g.add_edge("a", "c")
g.add_edge("b", "d")
g.add_edge("c", "d")

g.children_for("a")
g.parents_for("d")
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
