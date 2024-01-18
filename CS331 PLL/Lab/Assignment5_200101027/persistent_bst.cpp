#include <bits/stdc++.h>

using namespace std;

// Persistent BST

struct Node{
    int key;
    Node* left;
    Node* right;
};

class BST {
public:
    Node *root;

    BST() {
        root = nullptr;
    }

    Node *createNode(int key) {
        Node *newNode = new Node;
        newNode->key = key;
        newNode->left = nullptr;
        newNode->right = nullptr;
        return newNode;
    }

    Node *insert(Node *root, int key) {
        if (root == nullptr)
            return createNode(key);
        if (key < root->key)
            root->left = insert(root->left, key);
        else if (key > root->key)
            root->right = insert(root->right, key);
        return root;
    }

    bool search(Node* root, int key){
        if(root == nullptr){
            return false;
        }
        if(root->key == key){
            return true;
        }else if(root->key < key){
            return search(root->right, key);
        }else{
            return search(root->left, key);
        }
    }

    Node* InorderSucc(Node* node) {
        Node* current = node;
        while (current && current->left != nullptr){
            current = current->left;
        }
        return current;
    }

    Node *deleteNode(Node *root, int key) {
        if (root == nullptr) return root;

        if (key < root->key){
            root->left = deleteNode(root->left, key);
        }
        else if (key > root->key){
            root->right = deleteNode(root->right, key);
        }
        else{
            if (root->left == NULL) {
                Node *temp = root->right;
                free(root);
                return temp;
            } else if (root->right == NULL) {
                Node *temp = root->left;
                free(root);
                return temp;
            }

            Node *temp = InorderSucc(root->right);
            root->key = temp->key;
            root->right = deleteNode(root->right, temp->key);
        }
        return root;
    }

    Node *copyTree(Node *root) {
        if (root == nullptr)
            return nullptr;
        Node *newNode = createNode(root->key);
        newNode->left = copyTree(root->left);
        newNode->right = copyTree(root->right);
        return newNode;
    }
    
    BST persistentInsert(int key) {
        BST newBST;
        newBST.root = copyTree(root);
        newBST.root = newBST.insert(newBST.root, key);
        return newBST;
    }

    BST persistentDelete(int key) {
        BST newBST;
        newBST.root = copyTree(root);
        newBST.root = newBST.deleteNode(newBST.root, key);
        return newBST;
    }

    void inorder(Node* root){
        if(root!=nullptr){
            inorder(root->left);
            cout << root->key << " ";
            inorder(root->right);
        }
    }
};

int main() {
    BST bst1;
    int arr[7] = {50,30,20,40,70,60,80};
    for(int i=0; i<7; i++){
        bst1.root = bst1.insert(bst1.root, arr[i]);
    }

    // Test Case for Persistent Insert
    cout << "Test Case for Persistent Insert" << endl;
    BST bst2 = bst1.persistentInsert(55);
    bst1.inorder(bst1.root);
    cout << endl;
    bst2.inorder(bst2.root);
    cout << endl;
    cout << endl;

    // Test Case for Persistent Search
    cout << "Test Case for Persistent Search" << endl;
    if(bst1.search(bst1.root,55)){
		cout << "true";
	}else{
		cout << "false";
	}
	cout << " ";
	if(bst2.search(bst2.root,55)){
		cout << "true";
	}else{
		cout << "false";
	}
    cout << endl;
	cout << endl;

    // Test Case for Persistent Delete
    cout << "Test Case for Persistent Delete" << endl;
    bst1.inorder(bst1.root);
    cout << endl;
    BST bst3 = bst1.persistentDelete(70);
    bst3.inorder(bst3.root);
    cout << endl;

    return 0;
}