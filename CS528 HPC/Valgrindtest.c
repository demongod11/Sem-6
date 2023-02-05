#include <stdio.h>

void Work1(int n) { 
    int i=0,j=0,k=0; 
    while(i++<n){
        while(j++<n){
            while(k++<n);
            }
    }
}

void Work2(int n) { 
    int i=0; 
    while(i++<n);
}

void Maneger(int n1, int n2){
    Work1(n1); Work2(n2); 
}

void Projects1() { Maneger(1000000, 1000);}
void Projects2() { Maneger(100, 1000000);}

int main() {
    Projects1(); 
    Projects2(); 
    return 0;
}
