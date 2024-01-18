import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.*;
import java.io.*;

class Graph {
    private int vertices;
    private Map<Integer, List<Edge>> adjList;

    public Graph(int vertices) {
        this.vertices = vertices;
        this.adjList = new HashMap<>();
        for (int i = 0; i < vertices; i++) {
            adjList.put(i, new ArrayList<>());
        }
    }

    public void addEdge(int src, int dest, int weight) {
        adjList.get(src).add(new Edge(dest, weight));
        adjList.get(dest).add(new Edge(src, weight));
    }

    public void showAdjacencyList() {
        System.out.println("Adjacency List:");
        for (int v : adjList.keySet()) {
            System.out.print(v + " -> ");
            for (Edge edge : adjList.get(v)) {
                System.out.print("(" + edge.dest + ", " + edge.weight + ") ");
            }
            System.out.println();
        }
    }

    public void showGraph() {
        StringBuilder graph = new StringBuilder("graph G {\n");
        for (int v : adjList.keySet()) {
            for (Edge edge : adjList.get(v)) {
                if (v < edge.dest) {
                    graph.append("\t" + v + " -- " + edge.dest + " [label=" + edge.weight + "];\n");
                }
            }
        }
        graph.append("}\n");
        System.out.println("Graph:");
        System.out.println(graph);
    }

    public int[] dijkstra(int src, int dest) {
        int[] dist = new int[vertices];
        boolean[] visited = new boolean[vertices];
        Arrays.fill(dist, Integer.MAX_VALUE);
        dist[src] = 0;
        PriorityQueue<Node> heap = new PriorityQueue<>();
        heap.add(new Node(src, 0));
        while (!heap.isEmpty()) {
            Node curr = heap.poll();
            int currV = curr.vertex;
            visited[currV] = true;
            if (currV == dest) {
                break;
            }
            for (Edge edge : adjList.get(currV)) {
                int neighbor = edge.dest;
                if (!visited[neighbor]) {
                    int newDist = curr.distance + edge.weight;
                    if (newDist < dist[neighbor]) {
                        dist[neighbor] = newDist;
                        heap.add(new Node(neighbor, newDist));
                    }
                }
            }
        }
        return dist;
    }

    public void showShortestPath(int src, int dest) {
        int[] dist = dijkstra(src, dest);
        System.out.println("Shortest path from " + src + " to " + dest + ": " + dist[dest]);
    }

    public void showShortestPathInTheGraph(int src, int dest) {
        int[] dist = dijkstra(src, dest);
        Set<Edge> mst = findMinimumSpanningTree();
        Set<Edge> path = getShortestPath(src, dest, dist);
        StringBuilder graph = new StringBuilder("graph G {\n");
        for (int v : adjList.keySet()) {
            for (Edge edge : adjList.get(v)) {
                if (v < edge.dest) {
                    if (path.contains(edge) || path.contains(new Edge(edge.dest, edge.weight, v))) {
                        graph.append("\t" + v + " -- " + edge.dest + " [label=" + edge.weight + ", color=red];\n");
                    } else if (mst.contains(edge) || mst.contains(new Edge(edge.dest, edge.weight, v))) {
                        graph.append("\t" + v + " -- " + edge.dest + " [label=" + edge.weight + ", color=black];\n");
                    }
                }
            }
        }
        graph.append("}\n");
        System.out.println("Shortest path in the graph:");
        System.out.println(graph);
    }

    private Set<Edge> findMinimumSpanningTree() {
        Set<Edge> mst = new HashSet<>();
        boolean[] visited = new boolean[vertices];
        visited[0] = true;
        PriorityQueue<Edge> heap = new PriorityQueue<>();
        for (Edge edge : adjList.get(0)) {
            heap.add(edge);
        }
        while (!heap.isEmpty()) {
            Edge curr = heap.poll();
            int currV = curr.dest;
            if (!visited[currV]) {
                visited[currV] = true;
                mst.add(curr);
                for (Edge edge : adjList.get(currV)) {
                    if (!visited[edge.dest]) {
                        heap.add(edge);
                    }
                }
            }
        }
        return mst;
    }
    
    private Set<Edge> getShortestPath(int src, int dest, int[] dist) {
        Set<Edge> path = new HashSet<>();
        while (dest != src) {
            for (Edge edge : adjList.get(dest)) {
                if (dist[dest] == dist[edge.dest] + edge.weight) {
                    path.add(edge);
                    dest = edge.dest;
                    break;
                }
            }
        }
        return path;
    }
    
    private class Edge implements Comparable<Edge> {
        int dest;
        int weight;
    
        public Edge(int dest, int weight) {
            this.dest = dest;
            this.weight = weight;
        }
    
        public Edge(int dest, int weight, int src) {
            this.dest = dest;
            this.weight = weight;
        }
    
        @Override
        public int compareTo(Edge o) {
            return Integer.compare(weight, o.weight);
        }
    }
    
    private class Node implements Comparable<Node> {
        int vertex;
        int distance;
    
        public Node(int vertex, int distance) {
            this.vertex = vertex;
            this.distance = distance;
        }
    
        @Override
        public int compareTo(Node o) {
            return Integer.compare(distance, o.distance);
        }
    }
}

public class Que3 {
    public static void main(String[] args) {
        try{
            BufferedReader br = new BufferedReader(new FileReader("input3.txt"));
            String test_cases = br.readLine().strip();
            int T = Integer.parseInt(test_cases);
            for (int t = 1; t <= T; t++) {
                String[] n_m = (br.readLine().strip().split(" "));
                int N = Integer.parseInt(n_m[0]);
                int E = Integer.parseInt(n_m[1]);
                Graph graph = new Graph(N);
                for (int i = 0; i < E; i++) {
                    String[] ed = br.readLine().strip().split(" ");
                    int src = Integer.parseInt(ed[0]);
                    int dest = Integer.parseInt(ed[1]);
                    int weight = Integer.parseInt(ed[2]);
                    graph.addEdge(src, dest, weight);
                }
                graph.showAdjacencyList();
                graph.showGraph();
                String[] ed = br.readLine().strip().split(" ");
                int src = Integer.parseInt(ed[0]);
                int dest = Integer.parseInt(ed[1]);
                graph.showShortestPath(src, dest);
                graph.showShortestPathInTheGraph(src, dest);
            }
        }        
        catch(Exception e){
            e.printStackTrace();
        }

    }
}