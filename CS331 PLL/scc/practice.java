import java.util.*;
import java.io.*;

@SuppressWarnings("unchecked")

class Graph {
    int V;
    ArrayList<Integer>[] adj;

    Graph(int V) {
        this.V = V;
        adj = new ArrayList[V];
        for (int i = 0; i < V; i++) {
            adj[i] = new ArrayList<Integer>();
        }
    }

    void addEdge(int u, int v) {
        adj[u].add(v);
    }

    Graph getTranspose() {
        Graph g = new Graph(V);
        for (int u = 0; u < V; u++) {
            for (int v : adj[u]) {
                g.addEdge(v, u);
            }
        }
        return g;
    }

    void dfs(int u, boolean[] visited, Stack<Integer> stack) {
        visited[u] = true;
        for (int v : adj[u]) {
            if (!visited[v]) {
                dfs(v, visited, stack);
            }
        }
        stack.push(u);
    }

    void dfs(int u, boolean[] visited, List<Integer> component) {
        visited[u] = true;
        component.add(u);
        for (int v : adj[u]) {
            if (!visited[v]) {
                dfs(v, visited, component);
            }
        }
    }

    List<List<Integer>> getSCCs() {
        boolean[] visited = new boolean[V];
        Stack<Integer> stack = new Stack<Integer>();
        for (int u = 0; u < V; u++) {
            if (!visited[u]) {
                dfs(u, visited, stack);
            }
        }
        Graph gt = getTranspose();
        visited = new boolean[V];
        List<List<Integer>> sccs = new ArrayList<List<Integer>>();
        while (!stack.isEmpty()) {
            int u = stack.pop();
            if (!visited[u]) {
                List<Integer> component = new ArrayList<Integer>();
                gt.dfs(u, visited, component);
                sccs.add(component);
            }
        }
        return sccs;
    }

    void printGraph() {
        try{
            BufferedWriter writer = new BufferedWriter(new FileWriter("graph.dot",false));
            writer.write("digraph G{\n");
			writer.write("layout=circo");
            for(int i=0;i<V;i++){
                int x = i;
                for(int y :adj[i]){
                    writer.write("       "+Integer.toString(x) + "->" + Integer.toString(y) +"\n");
                }
            }
            writer.write("}");

            writer.close();

        }catch(IOException ex){
            ex.printStackTrace();
        }
		ProcessBuilder pb = new ProcessBuilder( "dot","-Tpng","graph.dot","-o","graph.png");
        pb.inheritIO();
        try{
            Process process = pb.start();
            process.waitFor();
        }catch(Exception e){
        }
    }

    void showAllSSC() {
        List<List<Integer>> sccs = getSCCs();
        try{
        BufferedWriter writer = new BufferedWriter(new FileWriter("components.dot",false));
		writer.write("digraph G{\n");
		writer.write("layout=circo");
		for(List<Integer> component:sccs){
			for(int i:component){
                if(component.size()==1){
                    writer.write("       "+Integer.toString(i)+"\n");
                }else{
                    for(int j:adj[i]){
                        if(component.indexOf(j)!=-1){
                            writer.write("       "+Integer.toString(i) + "->" + Integer.toString(j) +"\n");
                        }
                    }
                }	
			}
		}
    
		writer.write("}");
		writer.close();
        }catch(Exception e){

        }
		ProcessBuilder pb = new ProcessBuilder( "dot","-Tpng","components.dot","-o","components.png");
        pb.inheritIO();
        try{
            Process process = pb.start();
            process.waitFor();
        }catch(Exception e){
        }
    }

    void showComponentGraph() {
        List<List<Integer>> sccs = getSCCs();
        List<List<Integer>> cg = new ArrayList<>();
        for(int i = 0;i<sccs.size();i++){
            List<Integer> adj = new ArrayList<>();
            cg.add(adj);
        }
        Map<Integer, Integer> map = new HashMap<Integer, Integer>();
        for (int i = 0; i < sccs.size(); i++) {
            for (int u : sccs.get(i)) {
                map.put(u, i);
            }
        }
        for (int u = 0; u < V; u++) {
            int i = map.get(u);
            for (int v : adj[u]) {
                int j = map.get(v);
                if (i != j) {
                    cg.get(i).add(j);
                }
            }
        }
        String[] cstr = new String[sccs.size()];
        for(int i = 0;i<sccs.size();i++){
            cstr[i] = "\"";
            int x = 1;
            for(int j : sccs.get(i)){
                if(x==1){
                    cstr[i] += Integer.toString(j);
                }else{
                    cstr[i] += ","+Integer.toString(j);
                }
                x++;
            }
            cstr[i]+="\"";
        }
        try{
        BufferedWriter writer = new BufferedWriter(new FileWriter("componentgraph.dot",false));
        writer.write("digraph G{\n");
		writer.write("layout=circo\n");
        for(int i=0;i<cg.size();i++){
            for(int y :cg.get(i)){
                writer.write("       "+ cstr[i] + "->" + cstr[y] +"\n");
            }
        }
        writer.write("}");
        writer.close();
        }catch(Exception e){

        }
        ProcessBuilder pb = new ProcessBuilder( "dot","-Tpng","componentgraph.dot","-o","componentgraph.png");
        pb.inheritIO();
        try{
        Process process = pb.start();
        process.waitFor();
        }catch(Exception e){

        }
    }
}

public class practice {
    public static void main(String[] args) throws FileNotFoundException {
        File inputFile = new File("input.txt");
        Scanner scanner = new Scanner(inputFile);

        int numVertices = scanner.nextInt();
        Graph g = new Graph(numVertices);

        while (scanner.hasNext()) {
            int u = scanner.nextInt();
            int v = scanner.nextInt();
            g.addEdge(u, v);
        }
        scanner.close();

        g.printGraph();

        System.out.println();

        g.showAllSSC();
    
        System.out.println();
    
        g.showComponentGraph();
    }
}
    