#include <stdio.h>

void FunA() {
    int i=0,g=0;
    while(i++<100000)
    { g+=i; }
}

void FunB() {
    int i=0,g=0;
    while(i++<400000) 
    { g+=i; }
}

int main(){
    int iter=5000;
    while(iter--) {
        FunA();
        FunB();
    }
    return 0;
}
