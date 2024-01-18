#include <bits/stdc++.h>

using namespace std;

// Persistent Linked List

class Node {
public:
	int data;
	Node* next;
	Node()
	{
		data = 0;
		next = NULL;
	}
	Node(int data)
	{
		this->data = data;
		this->next = NULL;
	}
};

class Linkedlist {
	Node* head;

public:
	Linkedlist() { 
		head = NULL;
	}

	void insertNode(int data){
		Node* newNode = new Node(data);
		if (head == NULL) {
			head = newNode;
			return;
		}
		Node* temp = head;
		while (temp->next != NULL) {
			temp = temp->next;
		}
		temp->next = newNode;
	}

	void printList(){
	Node* temp = head;
		if (head == NULL) {
			cout << "List empty" << endl;
			return;
		}

		while (temp != NULL) {
			cout << temp->data << " ";
			temp = temp->next;
		}
	}

	void deleteNode(int nodeOffset){
		Node *temp1 = head, *temp2 = NULL;
		int ListLen = 0;

		if (head == NULL) {
			cout << "List empty." << endl;
			return;
		}
		while (temp1 != NULL) {
			temp1 = temp1->next;
			ListLen++;
		}

		if (ListLen < nodeOffset) {
			cout << "Index out of range"
				<< endl;
			return;
		}

		temp1 = head;

		if (nodeOffset == 1) {
			head = head->next;
			delete temp1;
			return;
		}

		while (nodeOffset-- > 1) {
			temp2 = temp1;
			temp1 = temp1->next;
		}
		temp2->next = temp1->next;
		
		delete temp1;
	}

	bool search(int val){
		if(head == nullptr){
			return false;
		}
		Node* curr = head;
		while(curr!=nullptr){
			if(curr->data == val){
				return true;
			}
			curr = curr->next;
		}
		return false;
	}

	int searchIndex(int val){
		if(head == nullptr){
			return -1;
		}
		int index=1;
		Node* curr = head;
		while(curr!=nullptr){
			if(curr->data == val){
				return index;
			}
			curr = curr->next;
			index++;
		}
		return -1;
	}

	Node *copyLinkedList(Node *head) {
        if (head == nullptr)
            return nullptr;
        Node *newNode = new Node(head->data);
        newNode->next = copyLinkedList(head->next);
        return newNode;
    }
    
    Linkedlist persistentInsert(int key) {
        Linkedlist newLinkedList;
        newLinkedList.head = copyLinkedList(head);
		newLinkedList.insertNode(key);
        return newLinkedList;
    }

	Linkedlist persistentDelete(int key) {
        Linkedlist newLinkedList;
		int index = searchIndex(key);
		if(index == -1){
			cout << "The value given as input does not exist in the linked list";
			return newLinkedList;
		}
        newLinkedList.head = copyLinkedList(head);
		newLinkedList.deleteNode(index);
        return newLinkedList;
    }
};


int main()
{
	Linkedlist list;

	int arr[4] = {10,20,30,40};
	for(int i=0; i<4; i++){
		list.insertNode(arr[i]);
	}

	// Test Case for Persistent Insert
	cout << "Test Case for Persistent Insert" << endl;
	Linkedlist list2 = list.persistentInsert(45);
	list2.printList();
	cout << endl;
	list.printList();
	cout << endl;
	cout << endl;

	// Test Case for Persistent Search
    cout << "Test Case for Persistent Search" << endl;
	if(list2.search(45)){
		cout << "true";
	}else{
		cout << "false";
	}
	cout << " ";
	if(list.search(45)){
		cout << "true";
	}else{
		cout << "false";
	}
    cout << endl;
	cout << endl;

	// Test Case for Persistent Delete
	cout << "Test Case for Persistent Delete" << endl;
	Linkedlist list3 = list.persistentDelete(30);
	list3.printList();
	cout << endl;
	list.printList();
	cout << endl;


	return 0;
}