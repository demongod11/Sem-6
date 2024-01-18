/* Test C Program to check all parser rules */

auto x = 3;
const unsigned int cui = 4;
short bit = 1;
const signed int csi = -4;
inline int addOne(int x){return x++;}
enum directions {NORTH = 1, SOUTH, EAST, WEST};
extern int globl;
static const double e = 2.71828182845904523536;

_Complex a = 1;
_Bool check = 0;

static int staticVar = 1;

void my_function(int* x, int* y, int* restrict z) {
   *x += *z;
   *y += *z;
   return;
}

int main()
{
    unsigned int sizeInt = sizeof(int);
    int var = 2;
    int temp;
    switch (var)
    {
    case 1:
        temp = 0;
        break;
    
    default:
        temp = 1;
        break;
    }

    while (temp)
    {
        /* code */
        temp = 0;
    }

    register int regVar = 1;

    do
    {
        /* code */
        temp = 0;
    } while (temp);

    if(temp < 10 || temp > 20) {
        temp = 0;
    } else {
        temp = 1;
    }

    for(int i=0; i<10; i++){
        if(i==0 || (i<=9 && i>=8)) continue;
        else break;
    }

    int int_const = 0;
    int int_const2 = 24301;
    double pi = 314e-2;
    float f = .321e+1;
    float f = .321E+1;
    double ld = -1.2e-3;

    enum directions dir = NORTH;
    char c = 'a';
    char newLine = '\n';
    char newLine = '\\';

    char str[] = "Hello World";
    char empty[] = "";

    float e_ = 2.71;

    // goto label;

    volatile int volVar = 1;
    volatile long volVarLong = 147483648;

    int _ab1029200 = 1;
    int _0000ax20 = 1;
    int M_123_ba00 = 1;

    int ptrVar = 23;
    int *ptr = &x;


    int test1, test2;
    test1++;
    test2--;
    test1 = test1 & test2;
    test1 = test1 | test2;
    test1 = test1 ^ test2;
    test1 = test1 >> test2;
    test1 = test1 << test2;
    test1 = test1 && test2;
    test1 = test1 == test2;
    test1 = test1 != test2;
    test1 = test1 <= test2;
    test1 = test1 >= test2;
    test1 = test1 < test2;
    test1 = test1 > test2;
    test1 = test1 ? test2 : test1 < test2;
    test1 *= test2;
    test1 /= test2;
    test1 %= test2;
    test1 += test2;
    test1 -= test2;
    test1 <<= test2;
    test1 >>= test2;
    test1 &= test2;
    test1 ^= test2;
    test1 |= test2;
    test1 = 1, test2 = 2;
    
    
}