# `gem install rgl` before running this script
require "rgl/adjacency"
require "rgl/dijkstra"
require "rgl/path"

def run(size, consume, filename)
  start = [0, 0]
  goal = [size - 1, size - 1]

  g = RGL::AdjacencyGraph[]
  (0...size).each { |i|
    (0...size).each { |j|
      g.add_edge([i, j], [i, j - 1]) if j > 0
      g.add_edge([i, j], [i - 1, j]) if i > 0
    }
  }

  obs = File.readlines(filename).map { |line| line.split(",").map(&:to_i) }
  obs.first(consume).each { |xy| g.remove_vertex(xy) }
  # length of a graph = number of nodes - 1
  puts g.dijkstra_shortest_path(Hash.new(1), start, goal).length - 1

  obs.each { |xy|
    g.remove_vertex(xy)
    unless g.path?(start, goal)
        puts xy.join(",")
        break
    end
  }
end

# process_graph(7, 12, "18.example.in")
run(71, 1024, "18.in")