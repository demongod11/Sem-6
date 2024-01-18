/*
---> CS39003 : Assignment-4
---> Name: Pritkumar Godhani + Debanjan Saha
---> Roll: 19CS10048 + 19CS30014
*/

// test: some specific keywords
extern double func1();
const float f1 = .2e-3;
restrict volatile short s = 15125;
static int func_count = -1;

void specialfunction() {
    // test : void, assignment operators, casting, arithmetic expression, empty argument list
    if(func_count > 0) {
        func_count -= 2;
        int x1 = func_count + (int)( f1 * 101.0/37 ) / 45;
    }

    if(func_count < 0) {
        func_count += 10;
        int x2 = func_count - (int) (f1/34.0) * 465;
    }

    if(func_count == 0) {
        func_count ++;
        func_count *= (23 * (int)(f1 * s / 1000.0));
    }
} 

int myfunc2(int var)
{
    // test : if-else, relational operators, return, arithmetic expressions, argument list
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
    // test: int, const, signed, const, various identifer names
    const signed x1 = -234;
    int var2 = 100;
    long _underscore = 34;

    // test : mulitline comment
    /*  all indetifiers name variation have been tested,
        we now test the floating point constants
        along with float and double */
    float decimal = 2.33;
    float with_positive_exponent = 4.3E2;
    float with_negative_exponent = 5.46E-3;
    double without_integer_part = .234;
    double without_fraction_part = 2456.;

    // test : char, string literals, array declaration, --, different uses of arrays
    char char_literal = '#';
    char string_literal[100] = "this will test string literals. Bison is so cool!! escape \' \\";
    int fibonacci[10];
    int a0 = 0, a1 = 1;
    for(int i = 9; i >= 0; i--) {
        fibonacci[i] = a0 + a1;
        a0 = a1;
        a1 = fibonacci[i];

    }
    
    // test : sizeof
    var2 = sizeof(string_literal);

    // test : &&, ?:, <<, ~, pointers (* and &), arrow, dot (for struct member access)
    _underscore = (var2 == 0) ? 1 : 2;
    var2 = _underscore && ~x1;
    var2 = var2 << 4;
    int *p1 = &var2;


    // test : loops, for, continue, ++, %, relational ops, do, while, --, >, break, !=
    for (int _varX = 0; _varX <= 1023; _varX++)
    {
        if (func_count % 33 == 12)
            continue;
        else
        {
            var2 += 1;
        }
    }
    do
    {
        var2--;
        if(func_count % 2 == 0 || (func_count % 3 != 1 && func_count % 3 != 2)) {
            var2 = 2;
            break;
        }
    } while (var2 > 0);


    // test : switch, case, default, break, bitwise operators
    switch (var2)
    {
        case 0:
            var2 = var2 * (func_count | ~x1);
            break;
        case 2:
            var2 = var2 & 43;
            var2 = x1 ^ 255;
            break;
        default:
            var2 = 33;
    }
  
}
