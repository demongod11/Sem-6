/*
*   Group - 9
*   Assignment-4, Compilers Lab
*   Aryan Agarwal, 19CS30005
*   Vinit Raj, 19CS10065
*/

static int lambda = 7;

int minimum(int a, int b)
{
  if(a<=b)
    return a;
  else
    return b;
}
int maximum(int a, int b)
{
  return (a>=b) ? a : b;
}

const int MOD = 1000000007;
const float half = 0.5;

extern short exported_funcion();

int main()
{
    float f = 123.87e-03;
    int n = 2021;
    double d = 123.456;
    char _ch = 'character_constant_too_long_for_its_type';
    char c = 'x';
    char str1[] = "I am a string\n";
    char arr2[] = ""; // empty string

    auto rows = 10;
    auto cols = 10;

    short i=0;
    do
    {
        short j=0;
        do
        {
            if(j==cols){
                printf("%d\n",i+j);
            }else{
                printf("%d ",i+j);
            }
            
        } while (j++ <cols);
    } while (i++ <rows);
    

    // I think therefore I am

    int arr[5];
    int n=5;
    for(int i=0;i<n;i++){
        arr[i]=i;
        printf("%d ",arr[i]);
    }
    printf("\n");


    
    return 0;
}
