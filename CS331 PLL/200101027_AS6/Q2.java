import java.io.*;

class ArrayList<E> {
    private static final int DEFAULT_CAPACITY = 10;

    private E[] data;
    private int size;

    public ArrayList() {
        this(DEFAULT_CAPACITY);
    }

    public ArrayList(int capacity) {
        data = (E[]) new Object[capacity];
        size = 0;
    }

    public int size() {
        return size;
    }

    public void add(E element) {
        if (size == data.length) {
            resize(data.length * 2);
        }
        data[size] = element;
        size++;
    }

    public E get(int index) {
        if (index < 0 || index >= size) {
            throw new IndexOutOfBoundsException("Index out of range: " + index);
        }
        return data[index];
    }

    public E set(int index, E element) {
        if (index < 0 || index >= size) {
            throw new IndexOutOfBoundsException("Index out of range: " + index);
        }
        E oldElement = data[index];
        data[index] = element;
        return oldElement;
    }

    private void resize(int capacity) {
        E[] newData = (E[]) new Object[capacity];
        for (int i = 0; i < size; i++) {
            newData[i] = data[i];
        }
        data = newData;
    }
}

class Pair<T, U> implements Comparable<Pair<T, U>>{
    T first;
    U second;
    Pair(T f, U s){
        this.first = f;
        this.second = s;
    }

    public int compareTo(Pair<T, U> comPair){
        Integer tmp1 = (Integer) this.first;
        Integer tmp2 = (Integer) comPair.first;
        return tmp1-tmp2;
    }
}

class Node{
    Pair<Integer,Integer> data = new Pair<Integer,Integer> (1,1);
    Node next;

    Node(int a, int b){
        this.data.first = a;
        this.data.second = b;
        next = null;
    }
}

class LinkedList{
    Node head;
    int size;
    public LinkedList(){
        this.head = null;
        this.size = 0;
    }

    public LinkedList insert(Pair<Integer, Integer> v){
        size++;
        if(this.head == null){
            this.head = new Node(v.first, v.second);
            return this;
        }
        Node curr = this.head;
        while(curr.next != null){
            curr = curr.next;
        }
        curr.next = new Node(v.first, v.second);
        return this;
    }

    public void printList(){
        Node curr = this.head;
        while(curr != null){
            System.out.print(curr.data.first+","+curr.data.second+" ");
            curr = curr.next;
        }
    }
}

class MinHeap<T extends Comparable<T>> {
    private T[] heap;
    private int size;
    private int capacity;

    // @SuppressWarnings("unchecked")
    public MinHeap() {
        this.capacity = 1000;
        this.heap = (T[]) new Comparable[capacity];
        this.size = 0;
        this.capacity = capacity;
    }

    public void insert(T value) {
        if (size == capacity) {
            throw new RuntimeException("Heap is full");
        }
        heap[size] = value;
        int index = size;
        while (index > 0 && heap[index].compareTo(heap[parent(index)]) < 0) {
            swap(index, parent(index));
            index = parent(index);
        }
        size++;
    }
    
    public int getSize(){
        return this.size;
    }

    public T removeMin() {
        if (size == 0) {
            throw new RuntimeException("Heap is empty");
        }
        T minValue = heap[0];
        heap[0] = heap[size - 1];
        size--;
        heapify(0);
        return minValue;
    }

    private void heapify(int index) {
        int smallest = index;
        int left = leftChild(index);
        int right = rightChild(index);
        if (left < size && heap[left].compareTo(heap[smallest]) < 0) {
            smallest = left;
        }
        if (right < size && heap[right].compareTo(heap[smallest]) < 0) {
            smallest = right;
        }
        if (smallest != index) {
            swap(index, smallest);
            heapify(smallest);
        }
    }

    private int parent(int index) {
        return (index - 1) / 2;
    }

    private int leftChild(int index) {
        return 2 * index + 1;
    }

    private int rightChild(int index) {
        return 2 * index + 2;
    }

    private void swap(int i, int j) {
        T temp = heap[i];
        heap[i] = heap[j];
        heap[j] = temp;
    }
}


class DisjointSet{
    ArrayList<Integer> size = new ArrayList<Integer>();
    ArrayList<Integer> UPar = new ArrayList<Integer>();
    public DisjointSet(int n){
        for(int i=0; i<n; i++){
            size.add(1);
            UPar.add(i);
        }
    }

    public int findUPar(int x){
        if(UPar.get(x) == x) return x;
        UPar.set(x, findUPar(UPar.get(x)));
        return UPar.get(x);
    }

    public void union(int x, int y){
        x = findUPar(x);
        y = findUPar(y);
        if(x == y) return;
        if(size.get(x) < size.get(y)){
            UPar.set(x,y);
            size.set(y,size.get(x)+size.get(y));
        }else{
            UPar.set(y,x);
            size.set(x,size.get(x)+size.get(y));
        }
    }
}

class Solution{
    public ArrayList<Pair<Integer,Pair<Integer,Integer>>> kruskal(ArrayList<Pair<Integer,Pair<Integer,Integer>>> g, int n){
        MinHeap<Pair<Integer,Pair<Integer,Integer>>> mh = new MinHeap<Pair<Integer,Pair<Integer,Integer>>>();
        ArrayList<Pair<Integer,Pair<Integer,Integer>>> mst = new ArrayList<Pair<Integer,Pair<Integer,Integer>>>();
        for(int i=0; i<g.size(); i++){
            mh.insert(g.get(i));
        }
        DisjointSet ds = new DisjointSet(n);
        while(mh.getSize() != 0){
            Pair<Integer,Pair<Integer,Integer>> temp = mh.removeMin();
            int x = temp.second.first;
            int y = temp.second.second;
            if(ds.findUPar(x) != ds.findUPar(y)){
                ds.union(x, y);
                mst.add(temp);
            }
        }
        return mst;
    }
}

public class Q2 {
    public static void systemCall(String name){
        ProcessBuilder pb = new ProcessBuilder("dot", name + ".dot" , "-Tpng", "-o", name + ".png");
        try {
            Process p = pb.start();
            p.waitFor();
        } 
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void printAdjacencyList(LinkedList[] adj, int n){
        for(int i=0; i<n; i++){
            System.out.print(i+" ");
            adj[i].printList();
            System.out.println("");
        }
    }

    public static void showAdjacencyList(LinkedList[] adj, int n, String name){
        try {
            FileWriter fp = new FileWriter(name+".dot");
            fp.write("digraph G{\n");
            fp.write("  rankdir = \"LR\"\n");
            fp.write("  node [shape = record]\n");
            fp.write("  gph [label = \"");
            for(int i=0; i<n; i++){
                if(i != n-1){
                    fp.write("<f"+i+"> " + i + " |");
                }else{
                    fp.write("<f"+i+"> " + i + " \"]\n");
                }
            }
            for(int i=0; i<n; i++){
                Node curr = adj[i].head;
                int j=0;
                while(curr != null){
                    fp.write("  gph"+i+""+j+" [label = \"{ "+ curr.data.first + " | " + curr.data.second + " | }\"]\n");
                    curr = curr.next;
                    j++;
                }
            }
            for(int i=0; i<n; i++){
                Node curr = adj[i].head;
                fp.write("  gph:f" + i + " -> gph"+i+"0\n");
                int j=0;
                while(curr.next != null){
                    int tmp = j+1;
                    fp.write("  gph"+i+""+j + " -> gph"+i+""+tmp + "\n");
                    curr = curr.next;
                    j++;
                }
            }
            fp.write("}");
            fp.close();
        }
        catch (IOException e) {
            System.out.print(e.getMessage());
        }
        systemCall(name);        
    }

    public static void showGraph(ArrayList<Pair<Integer,Pair<Integer,Integer>>> graph, String name){
        try {
            FileWriter fp = new FileWriter(name+".dot");
            fp.write("graph G{\n");
            fp.write("  rankdir = \"LR\"\n");
            for(int i=0; i<graph.size(); i++){
                fp.write("  "+graph.get(i).second.first+" -- "+graph.get(i).second.second+" [label = " + graph.get(i).first + "]\n");
            }
            fp.write("}");
            fp.close();
        }
        catch (IOException e) {
            System.out.print(e.getMessage());
        }
        systemCall(name);
    }

    public static void showMSTinGraph(ArrayList<Pair<Integer,Pair<Integer,Integer>>> graph, ArrayList<Pair<Integer,Pair<Integer,Integer>>> mst, String name){
        try {
            FileWriter fp = new FileWriter(name+".dot");
            fp.write("graph G{\n");
            fp.write("  rankdir = \"LR\"\n");
            for(int i=0; i<graph.size(); i++){
                int flag = 0;
                for(int j=0; j<mst.size(); j++){
                    if(graph.get(i).first == mst.get(j).first && graph.get(i).second.first == mst.get(j).second.first && graph.get(i).second.second == mst.get(j).second.second){
                        flag = 1;
                    }
                }
                if(flag == 1){
                    fp.write("  "+graph.get(i).second.first+" -- "+graph.get(i).second.second+" [label = " + graph.get(i).first + " color = \"red\"]\n");
                }else{
                    fp.write("  "+graph.get(i).second.first+" -- "+graph.get(i).second.second+" [label = " + graph.get(i).first + "]\n");
                }
            }
            fp.write("}");
            fp.close();
        }
        catch (IOException e) {
            System.out.print(e.getMessage());
        }
        systemCall(name);
    }

    public static void main(String[] args) {
        try{
            BufferedReader br = new BufferedReader(new FileReader("input_2.txt"));
            String test_cases = br.readLine().strip();
            int t = Integer.parseInt(test_cases);
            for(int i=0; i<t; i++){
                String[] inp = (br.readLine().strip().split(" "));
                int n = Integer.parseInt(inp[0]);
                int e = Integer.parseInt(inp[1]);
                int u,v,w;
                LinkedList adj[] = new LinkedList[n];
                ArrayList<Pair<Integer,Pair<Integer,Integer>>> g1 = new ArrayList<Pair<Integer,Pair<Integer,Integer>>>();
                for(int j=0; j<n; j++){
                    adj[j] = new LinkedList();
                }
                for(int j=0; j<e; j++){
                    String[] ed = br.readLine().strip().split(" ");
                    u = Integer.parseInt(ed[0]);
                    v = Integer.parseInt(ed[1]);
                    w = Integer.parseInt(ed[2]);
                    Pair<Integer, Integer> tmp1 = new Pair<Integer, Integer>(u,v);
                    Pair<Integer,Pair<Integer,Integer>> tmp2 = new Pair<Integer,Pair<Integer,Integer>> (w,tmp1);
                    g1.add(tmp2);
                    Pair<Integer,Integer> t1 = new Pair<Integer,Integer> (v,w);
                    Pair<Integer,Integer> t2 = new Pair<Integer,Integer> (u,w);
                    adj[u].insert(t1);
                    adj[v].insert(t2);
                }
                // printAdjacencyList(adj,n);
                Solution obj = new Solution();
                ArrayList<Pair<Integer,Pair<Integer,Integer>>> mst = obj.kruskal(g1,n);
                showAdjacencyList(adj, n, "Q2_Adj_List_" + (i+1));
                showGraph(g1, "Q2_Graph_"+(i+1));
                showGraph(mst, "MST_Graph_"+(i+1));
                showMSTinGraph(g1,mst,"MST_in_Graph_"+(i+1));
            }
            br.close();
        }
        catch(Exception e){
            e.printStackTrace();
        }
    }
}