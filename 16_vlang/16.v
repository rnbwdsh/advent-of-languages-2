import os
import datatypes


struct Node {
	x   int
	y   int
	dir int
}

fn (n Node) hash() int {
	return n.x + n.y << 12 + n.dir << 24
}

fn (n Node) move() Node {
	directions := [[1, 0], [0, 1], [-1, 0], [0, -1]]
	return Node{n.x + directions[n.dir][0], n.y + directions[n.dir][1], n.dir}
}

fn unhash(h int) Node {
	return Node{h & 4095, (h >> 12) & 4095, (h >> 24) & 3}
}

fn (n Node) rotate(amount int) Node {
	return Node{n.x, n.y, (n.dir + amount + 4) % 4}
}

fn dijkstra(graph map[int][]Node, adj_graph map[int]map[int]int, start Node) map[int]int {
	mut dist := {start.hash(): 0}
	mut to_visit := datatypes.Set[int]{}
	to_visit.add(start.hash())

	for !to_visit.is_empty() {
		curr := to_visit.pop() or { panic('no more nodes to visit') }
		to_visit.remove(curr)
		for next, weight in adj_graph[curr] {
			if dist[next] or { max_int } > (dist[curr] + weight) {
				dist[next] = dist[curr] + weight
				to_visit.add(next)
			}
		}
	}
	return dist
}

fn add_node_to_graph(mut graph map[int][]Node, n Node, lines []string) {
	graph[n.hash()] = [n.rotate(1), n.rotate(3)]
	next_node := n.move()
	if lines[next_node.x][next_node.y] != `#` {
		graph[n.hash()] << next_node
	}
}

// point 0/0 is unallocated -> safe
null := Node{0, 0, 0}
mut graph := map[int][]Node{}
mut start := null
mut end := null

// go over the input and build the graph
lines := os.read_file('16.in')!.split('\n')
for i in 0 .. lines.len {
	for j in 0 .. lines[i].len {
		if lines[i][j] != `#` {
			for k in 0 .. 4 {
				add_node_to_graph(mut graph, Node{i, j, k}, lines)
			}
			if lines[i][j] == `S` {
				start = Node{i, j, 1}
			}
			if lines[i][j] == `E` {
				end = Node{i, j, 0}
			}
		}
	}
}
// println(places)
if start == null || end == null {
	panic('start or end not found')
}

// build a dijkstra to get the distance from start to end
mut adj_graph := map[int]map[int]int{}
for a_hash, mut nodes in graph {
	a := unhash(a_hash)
	for b in nodes {
		adj_graph[a_hash][b.hash()] = if a.dir == b.dir { 1 } else { 1000 }
	}
}

// connect all end-nodes to the null node, for easy dijkstra
for dir in 0 .. 4 {
	adj_graph[end.rotate(dir).hash()][null.hash()] = 0
}

mut adj_transpose := map[int]map[int]int{}
for ah, _ in graph {
	for b, weight in adj_graph[ah] {
		adj_transpose[b][ah] = weight
	}
}
dist := dijkstra(graph, adj_graph, start)
dist_end := dijkstra(graph, adj_transpose, null)
shortest_path := dist[0]
println('A: ${shortest_path}')

// part B - count unique nodes (x, y, no direction) that are on the shortest path
mut unique_nodes := datatypes.Set[int]{}
dir_mask := 1 << 24 - 1
for node, _ in graph {
	if dist[node] + dist_end[node] == shortest_path {
		unique_nodes.add(node & dir_mask)
	}
}
println('B: ${unique_nodes.size()}')
