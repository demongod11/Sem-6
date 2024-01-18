#include <bits/stdc++.h>

using namespace std;

// LinkedList concatenate(LinkedList list1, LinkedList list2) {
//     Node *current = list1.head;
//     while (current->next != nullptr) {
//         current = current->next;
//     }
//     current->next = list2.head;
//     list1.tail = list2.tail;
//     return list1;
// }

class Node {
    int key;
    Node *left, *right;
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
        newNode->left = newNode->right = nullptr;
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

    Node *copyTree(Node *root) {
        if (root == nullptr)
            return nullptr;
        Node *newNode = createNode(root->key);
        newNode->left = copyTree(root->left);
        newNode->right = copyTree(root->right);
        return newNode;
    }

    BST makePersistent(int key) {
        BST newBST;
        newBST.root = copyTree(root);
        newBST.root = newBST.insert(newBST.root, key);
        return newBST;
    }
};

int main() {
    BST bst1;
    bst1.root = bst1.insert(bst1.root, 50);
    bst1.root = bst1.insert(bst1.root, 30);
    bst1.root = bst1.insert(bst1.root, 20);
    bst1.root = bst1.insert(bst1.root, 40);
    bst1.root = bst1.insert(bst1.root, 70);
    bst1.root = bst1.insert(bst1.root, 60);
    bst1.root = bst1.insert(bst1.root, 80);

    BST bst2 = bst1.makePersistent(55);

    // bst1 remains unchanged
    // bst2 has a new node with key 55

    return 0;
}