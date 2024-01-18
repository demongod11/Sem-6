#include "y.tab.h"
#include "stdio.h"

int main() {
    int val = yyparse();
    if(!val)
        printf("\n\nSUCCESS\n");
    else
        printf("\n\nError\n");
    return 0;
}