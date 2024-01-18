#include "y.tab.h"
#include "stdio.h"

int main() {
    int val = yyparse();

    if(!val)
        printf("\n\nSUCCESS");
    else
        printf("\n\nERROR");
    return 0;
}