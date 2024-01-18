import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.*;

class Graph {
    int V, E;
    Edge[] edges;

    Graph(int V, int E) {
        this.V = V;
        this.E = E;
        edges = new Edge[E];
        for (int i = 0; i < E; i++) {
            edges[i] = new Edge();
        }
    }

    class Edge implements Comparable<Edge> {
        int src, dest, weight;

        public int compareTo(Edge compareEdge) {
            return this.weight - compareEdge.weight;
        }
    }

    class Subset {
        int parent, rank;
    }

    int find(Subset[] subsets, int i) {
        if (subsets[i].parent != i) {
            subsets[i].parent = find(subsets, subsets[i].parent);
        }
        return subsets[i].parent;
    }

    void union(Subset[] subsets, int x, int y) {
        int xroot = find(subsets, x);
        int yroot = find(subsets, y);

        if (subsets[xroot].rank < subsets[yroot].rank) {
            subsets[xroot].parent = yroot;
        } else if (subsets[xroot].rank > subsets[yroot].rank) {
            subsets[yroot].parent = xroot;
        } else {
            subsets[yroot].parent = xroot;
            subsets[xroot].rank++;
        }
    }

    void kruskalMST() {
        Edge[] result = new Edge[V];
        int e = 0;
        int i = 0;
        for (i = 0; i < V; i++) {
            result[i] = new Edge();
        }

        Arrays.sort(edges);

        Subset[] subsets = new Subset[V];
        for (i = 0; i < V; i++) {
            subsets[i] = new Subset();
            subsets[i].parent = i;
            subsets[i].rank = 0;
        }

        i = 0;
        while (e < V - 1 && i < E) {
            Edge next_edge = edges[i++];

            int x = find(subsets, next_edge.src);
            int y = find(subsets, next_edge.dest);

            if (x != y) {
                result[e++] = next_edge;
                union(subsets, x, y);
            }
        }

        String dotFileContent = "graph {\n";
        String mstDotFileContent = "graph {\n";
        for (int j = 0; j < E; j++) {
            dotFileContent += edges[j].src + " -- " + edges[j].dest + " [label=\"" + edges[j].weight + "\"]\n";
            mstDotFileContent += result[j].src + " -- " + result[j].dest + " [label=\"" + result[j].weight + "\"";
            if (result[j].weight > 0) {
                mstDotFileContent += ", color=green, penwidth=2.0";
            }
            mstDotFileContent += "]\n";
        }
        dotFileContent += "}\n";
        mstDotFileContent += "}\n";

        String dotFilePath = "original_graph.dot";
        String mstDotFilePath = "mst.dot";
        String mstInGraphDotFilePath = "mst_in_graph.dot";
        String dotImageFilePath = "original_graph.png";
        String mstImageFilePath = "mst.png";
        String mstInGraphImageFilePath = "mst_in_graph.png";
        try {
            FileWriter dotFileWriter = new FileWriter(dotFilePath);
            dotFileWriter.write(dotFileContent);
            dotFileWriter.close();
            FileWriter mstDotFileWriter = new FileWriter(mstDotFilePath);
            mstDotFileWriter.write(mstDotFileContent);
            mstDotFileWriter.close();
        } catch (IOException ex) {
            System.out.println("Error writing DOT files: " + ex.getMessage());
        }
    
        String dotCommand = "dot -Tpng " + dotFilePath + " -o " + dotImageFilePath;
        String mstDotCommand = "dot -Tpng " + mstDotFilePath + " -o " + mstImageFilePath;
        String mstInGraphDotCommand = "dot -Tpng " + mstDotFilePath + " -o " + mstInGraphImageFilePath;
    
        try {
            Process dotProcess = Runtime.getRuntime().exec(dotCommand);
            dotProcess.waitFor();
            Process mstDotProcess = Runtime.getRuntime().exec(mstDotCommand);
            mstDotProcess.waitFor();
            Process mstInGraphDotProcess = Runtime.getRuntime().exec(mstInGraphDotCommand);
            mstInGraphDotProcess.waitFor();
        } catch (IOException ex) {
            System.out.println("Error executing DOT command: " + ex.getMessage());
        } catch (InterruptedException ex) {
            System.out.println("Error waiting for DOT command execution: " + ex.getMessage());
        }
    
        System.out.println("Original graph:");
        System.out.println(dotFileContent);
        System.out.println("MST:");
        System.out.println(mstDotFileContent);
        System.out.println("MST in original graph:");
        System.out.println("See mst_in_graph.png");
    
        try {
            Process viewProcess = Runtime.getRuntime().exec("eog " + mstInGraphImageFilePath);
            viewProcess.waitFor();
        } catch (IOException ex) {
            System.out.println("Error executing image viewer command: " + ex.getMessage());
        } catch (InterruptedException ex) {
            System.out.println("Error waiting for image viewer command execution: " + ex.getMessage());
        }
    }
}

public class SatQ2 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int t = scanner.nextInt();
        for (int i = 0; i < t; i++) {
            int n = scanner.nextInt();
            int e = scanner.nextInt();
            Graph graph = new Graph(n, e);

            for (int j = 0; j < e; j++) {
                int src = scanner.nextInt();
                int dest = scanner.nextInt();
                int weight = scanner.nextInt();
                graph.edges[j].src = src;
                graph.edges[j].dest = dest;
                graph.edges[j].weight = weight;
            }

            graph.kruskalMST();
        }
    }
}