#include "y.tab.h"
#include "stdio.h"

extern int yydebug;

int main() {
    int val = yyparse();
    yydebug = 1;
    
    if(!val)
        printf("\n\nSUCCESS");
    else
        printf("\n\nERROR BROOOO");
    return 0;
}