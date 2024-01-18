import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileNotFoundException;
import java.util.List;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;
import java.util.Stack;
import java.util.Scanner;

public class main {

    public static void main(String[] args) {
        DirectedGraph graph = readGraphFromFile("graph.txt");
        System.out.println("Original graph:");
        graph.printGraph();
        System.out.println("Strongly connected components:");
        graph.showAllSSC();
        System.out.println("Component graph:");
        graph.showComponentGraph();
    }

    public static DirectedGraph readGraphFromFile(String filename) {
        Scanner scanner = null;
        try {
            scanner = new Scanner(new File(filename));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            System.exit(1);
        }
        int V = scanner.nextInt();
        int E = scanner.nextInt();
        DirectedGraph graph = new DirectedGraph(V);
        for (int i = 0; i < E; i++) {
            int u = scanner.nextInt();
            int v = scanner.nextInt();
            graph.addEdge(u, v);
        }
        scanner.close();
        return graph;
    }

    static class DirectedGraph {
       
        private int V;
    private List<Integer>[] adjList;
    
    public DirectedGraph(int V) {
        this.V = V;
        adjList = new ArrayList[V];
        for (int i = 0; i < V; i++) {
            adjList[i] = new ArrayList<Integer>();
        }
    }
    
    public void addEdge(int u, int v) {
        adjList[u].add(v);
    }
    
    public List<List<Integer>> findSSCs() {
        Stack<Integer> stack = new Stack<>();
        boolean[] visited = new boolean[V];
        for (int i = 0; i < V; i++) {
            if (!visited[i]) {
                dfs(i, visited, stack);
            }
        }
        DirectedGraph transposedGraph = getTranspose();
        visited = new boolean[V];
        List<List<Integer>> sscList = new ArrayList<>();
        while (!stack.isEmpty()) {
            int v = stack.pop();
            if (!visited[v]) {
                List<Integer> ssc = new ArrayList<>();
                transposedGraph.dfs(v, visited, ssc);
                sscList.add(ssc);
            }
        }
        return sscList;
    }
    
    private void dfs(int v2, boolean[] visited, Stack<Integer> stack) {
        visited[v2] = true;
        for (int i : adjList[v2]) {
            if (!visited[i]) {
                dfs(i, visited, stack);
            }
        }
        stack.push(v2);
    }

    private void dfs(int v, boolean[] visited, List<Integer> component) {
        visited[v] = true;
        component.add(v);
        for (int neighbor : adjList[v]) {
            if (!visited[neighbor]) {
                dfs(neighbor, visited, component);
            }
        }
    }
    
    
    private DirectedGraph getTranspose() {
        DirectedGraph transposedGraph = new DirectedGraph(V);
        for (int i = 0; i < V; i++) {
            for (int j : adjList[i]) {
                transposedGraph.addEdge(j, i);
            }
        }
        return transposedGraph;
    }
    
    public void printGraph() {
        StringBuilder dot = new StringBuilder("digraph {\n");
        for (int v = 0; v < V; v++) {
            dot.append(String.format("  %d;\n", v));
            for (int neighbor : adjList[v]) {
                dot.append(String.format("  %d -> %d;\n", v, neighbor));
            }
        }
        dot.append("}\n");
    
        try {
            String fileName = "graph";
            String dotFilePath = fileName + ".dot";
            String pngFilePath = fileName + ".png";
            Files.write(Paths.get(dotFilePath), dot.toString().getBytes());
    
            ProcessBuilder pb = new ProcessBuilder("dot", "-Tpng", dotFilePath, "-o", pngFilePath);
            pb.redirectErrorStream(true);
            Process p = pb.start();
            p.waitFor();
    
            System.out.printf("Graph saved to %s and %s.%n", dotFilePath, pngFilePath);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
    }
    
    public void showAllSSC() {
        List<List<Integer>> sscList = findSSCs();
        for (List<Integer> ssc : sscList) {
            System.out.print("SSC: ");
            for (int v : ssc) {
                System.out.print(v + " ");
            }
            System.out.println();
        }
    }
    
    public void showComponentGraph() {
        List<List<Integer>> sscList = findSSCs();
        DirectedGraph componentGraph = new DirectedGraph(sscList.size());
        Map<Integer, Integer> sscMap = new HashMap<>();
        int sscIndex = 0;
        for (List<Integer> ssc : sscList) {
            for (int v : ssc) {
                sscMap.put(v, sscIndex);
            }
            sscIndex++;
        }
        for (int i = 0; i < V; i++) {
            for (int j : adjList[i]) {
                int ssc1 = sscMap.get(i);
                int ssc2 = sscMap.get(j);
                if (ssc1 != ssc2) {
                    componentGraph.addEdge(ssc1, ssc2);
                }
            }
        }
        componentGraph.printGraphViz();
    }
    public void printGraphViz() {
        PrintWriter writer = null;
        try {
            writer = new PrintWriter("graph.dot", "UTF-8");
            writer.println("digraph G {");
            for (int i = 0; i < V; i++) {
                writer.println("\t" + i + " [label=\"" + i + "\"];");
            }
            for (int i = 0; i < V; i++) {
                for (int j : adjList[i]) {
                    writer.println("\t" + i + " -> " + j + ";");
                }
            }
            writer.println("}");
            writer.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            Runtime.getRuntime().exec("dot -Tpng graph.dot -o graph.png");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    }
}
