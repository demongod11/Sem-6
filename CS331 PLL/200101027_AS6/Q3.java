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

class Solution{
    public ArrayList<Pair<Integer,Pair<Integer,Integer>>> dijkstra(LinkedList adj[], int n, int s, int d){
        MinHeap<Pair<Integer,Integer>> mh = new MinHeap<Pair<Integer,Integer>>();
        ArrayList<Pair<Integer,Pair<Integer,Integer>>> sp = new ArrayList<Pair<Integer,Pair<Integer,Integer>>>();
        ArrayList<Integer> dist = new ArrayList<Integer>();
        ArrayList<Pair<Integer,Integer>> par = new ArrayList<Pair<Integer,Integer>> ();
        for(int i=0; i<n; i++){
            par.add(new Pair<Integer,Integer>(-1,Integer.MAX_VALUE));
            if(i == s){
                dist.add(0);
            }else{
                dist.add(Integer.MAX_VALUE);
            }
        }
        mh.insert(new Pair<Integer,Integer>(0,s));
        while(mh.getSize() != 0){
            Pair<Integer,Integer> tmp = mh.removeMin();
            int node = tmp.second;
            int curr_dist = tmp.first;
            Node curr = adj[node].head;
            while(curr != null){
                int sec_node = curr.data.first;
                int wt = curr.data.second;
                if(curr_dist + wt < dist.get(sec_node)){
                    dist.set(sec_node, curr_dist+wt);
                    par.set(sec_node, new Pair<Integer,Integer>(node,wt));
                    mh.insert(new Pair<Integer,Integer>(curr_dist+wt, sec_node));
                }
                curr = curr.next;
            }
        }
        int dum = d;
        while(par.get(dum).first != -1){
            Pair<Integer,Integer> temp1 = new Pair<Integer,Integer> (par.get(dum).first, dum);
            Pair<Integer,Pair<Integer,Integer>> temp2 = new Pair<Integer,Pair<Integer,Integer>> (par.get(dum).second, temp1);
            sp.add(temp2);
            dum = par.get(dum).first;
        }
        return sp;
    }
}

public class Q3 {
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
            fp.write("  struct [label = \"");
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
                    fp.write("  struct"+i+""+j+" [label = \"{ "+ curr.data.first + " | " + curr.data.second + " | }\"]\n");
                    curr = curr.next;
                    j++;
                }
            }
            for(int i=0; i<n; i++){
                Node curr = adj[i].head;
                fp.write("  struct:f" + i + " -> struct"+i+"0\n");
                int j=0;
                while(curr.next != null){
                    int tmp = j+1;
                    fp.write("  struct"+i+""+j + " -> struct"+i+""+tmp + "\n");
                    curr = curr.next;
                    j++;
                }
            }
            fp.write("}");
            fp.close();
            systemCall(name);
        }
        catch (IOException e) {
            System.out.print(e.getMessage());
        }        
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
            systemCall(name);
        }
        catch (IOException e) {
            System.out.print(e.getMessage());
        }
    }
    
    public static void showShortestPathinGraph(ArrayList<Pair<Integer,Pair<Integer,Integer>>> graph, ArrayList<Pair<Integer,Pair<Integer,Integer>>> sp, String name){
        try {
            FileWriter fp = new FileWriter(name+".dot");
            fp.write("graph G{\n");
            fp.write("  rankdir = \"LR\"\n");
            for(int i=0; i<graph.size(); i++){
                int flag = 0;
                for(int j=0; j<sp.size(); j++){
                    if(graph.get(i).first == sp.get(j).first && graph.get(i).second.first == sp.get(j).second.first && graph.get(i).second.second == sp.get(j).second.second){
                        flag = 1;
                    }
                }
                if(flag == 1){
                    fp.write("  "+graph.get(i).second.first+" -- "+graph.get(i).second.second+" [label = " + graph.get(i).first + " color = \"yellow\"]\n");
                    fp.write("  " + graph.get(i).second.first + " [style = \"filled\" fillcolor = \"yellow\"]\n");               
                    fp.write("  " + graph.get(i).second.second + " [style = \"filled\" fillcolor = \"yellow\"]\n");                  
                }else{
                    fp.write("  "+graph.get(i).second.first+" -- "+graph.get(i).second.second+" [label = " + graph.get(i).first + "]\n");
                }
            }
            fp.write("}");
            fp.close();
            systemCall(name);
        }
        catch (IOException e) {
            System.out.print(e.getMessage());
        }
    }
    public static void main(String[] args) {
        try{
            BufferedReader br = new BufferedReader(new FileReader("input_3.txt"));
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
                int s,d;
                String[] ed = br.readLine().strip().split(" ");
                s = Integer.parseInt(ed[0]);
                d = Integer.parseInt(ed[1]);

                Solution obj = new Solution();
                ArrayList<Pair<Integer,Pair<Integer,Integer>>> sp = obj.dijkstra(adj,n,s,d);
                showAdjacencyList(adj, n, "Q3_Adj_List_"+(i+1));
                showGraph(g1, "Q3_Graph_"+(i+1));
                showGraph(sp, "SP_Graph_"+(i+1));
                showShortestPathinGraph(g1,sp,"SP_in_Graph_"+(i+1));
            }
            br.close();
        }
        catch(Exception e){
            e.printStackTrace();
        }
    }
}