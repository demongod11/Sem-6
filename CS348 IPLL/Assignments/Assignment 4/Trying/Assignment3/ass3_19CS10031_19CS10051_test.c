void specialfunction() {
    if(func_count > 0) {
        func_count = func_count - 2;
        int x1 = func_count + ( f1 * 101/37 ) / 45;
    }

    if(func_count < 0) {
        func_count = func_count+10;
        int x2 = func_count - (f1/34) * 465;
    }

    if(func_count == 0) {
        func_count = func_count+1;
        func_count = func_count*(23 * (f1 * 1 / 1000));
    }
} 

int myfunc2(int var)
{
    // test : if-else, relational expression, return, arithmetic expressions, argument list
    if (var > 30)
    {
        var = var * 13;
        return var;
    }
    else
    {
        return var + 203;
    }
}


int main()
{
    // test : single line comment
    // test: int,char various identifer names
    int x1 = -234;
    int _underscore = 34;
    char c='a';
    

    // test : mulitline comment
    /*  all indetifiers name variation have been tested,
        char, string literals, array declaration, different uses of arrays */
    char char_literal = '#';
    char string_literal[100] = "this will test string literals. Bison is so cool!! escape \' \\";
    int fibonacci[10];
    int a0 = 0;
    int a1 = 1;
    for( i = 9; i < 10; i=i-1) {
        fibonacci[i] = a0 + a1;
        a0 = a1;
        a1 = fibonacci[var2];

    }

    // test : 
    var2 = var2 + 4;
    int *p1 = &var2;

    int _varX=0;
    // test : loops, for, ++, %, relational ops, >, !=
    for ( _varX = 0; _varX <= 1023; _varX=_varX+1)
    {
        if (func_count % 33 == 12)
            func_count=20;
        else
        {
            var2 = var2 + 1;
        }
    }

	// test : &&, ?:, <<, pointer (*), arrow
    _underscore = (var2 == 0) ? 1 : 2;
    var2 = _underscore && x1;
    var2 = var2 + 4;
    int *p1 = &var2;

    int _varX=0;
    // test : loops, for, ++, %, relational ops, >, !=
    for ( _varX = 0; _varX <= 1023; _varX=_varX+1)
    {
        if (func_count % 33 == 12)
            func_count=20;
        else
        {
            var2 = var2 + 1;
        }
    }
  
}