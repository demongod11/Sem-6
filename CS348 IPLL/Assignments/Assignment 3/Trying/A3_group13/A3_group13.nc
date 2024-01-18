void swap(int *p, int *q);

char a = 'b';
int zb = -500;

int main() {
    int x = 30;
    int y = 20;
    x = x + y;
    if(x<=20)
    {
        return 20;
    }
    swap(&x,&y);
    char c='a';
    char str[5]="check";
    int n = 10;
    int r;
    r = rec(n);
    printStr("fibo(");
    printInt(n);
    printStr(") = ");
    printInt(r);
    return 0;
    return 0;
}

void swap(int *p, int *q) { /* Swap two numbers */
    int t = *p;
    *p = *q;
    *q = t;
}


void random_func(int n) { 
    /* A function to 
        implement bubble sort */
    int i;
    int j;
    for (i = 0; i < n - 1; i = i + 1)
        // Last i elements are already in place
        for (j = 0; j < n - i - 1; j = j + 1)
            if (arr[j] > arr[j + 1])
                swap(&arr[j], &arr[j + 1]);
}

int odd_case(int);
int even_case(int);
int rec(int n) {
    return (n % 2 == 0)? even_case(n): odd_case(n);
}
int odd_case(int n) {
    return (n == 1)? 1: even_case(n-1) + odd_case(n-2);
}
int even_case(int n) {
    return (n == 0)? 0: odd_case(n-1) + even_case(n-2);
}