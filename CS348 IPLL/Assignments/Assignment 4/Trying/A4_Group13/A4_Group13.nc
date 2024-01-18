// Testing Functions, return statement
int randomFunction(){
	return Randomising;
}

void some_void_fun(){
	int p;
    p = randomFunction();
	p = p * 2;
}

// Testing arithmetic expressions, arguments in functions
int useless_function(int par, int var){
    ab = randomFunction();
    ab = ab * par;
    ab = ab - var;
    return ab;
}

int main()
{
    /* Testing Multi Line Comment and
        1D array, int, char, string */
	int n;
	int array[2000];
    int brray[2000];
	char char_const;
	int a = array[0];
    char str_lit[10] = "Compilers";

    // Testing for loop and relational operators
	for (i = 0; i < n; i=i+1){
        if(array[i] > array[i+1]){
		    array[i] = array[i] * 34;
        }

        if(array[i] < array[i+1]){
		    array[i] = array[i] / 34;
        }

        if(array[i] = array[i+1]){
		    array[i] = array[i] - 1;
        }
	}

	for (c = n - 1; c >= 0; c=c-1){
		d = d+c;
	}

	int alpha = 67;
	int gandhi = 23;
	a = b + 45;
	int z = a;
	for (c = 0; c <= n - 1; c = c+1){
        // Testing if else and Single Line Comment
		if(sajal == gandhi){
            z = z*5;
        }else{
            x = x*z;
        }
	}

	// Testing ->,*,/,+,%,||,!,&&,& operations
	int *x = &a;
	x->a;
	a = !a;
	a = a * c;
	a = a / b;
	a = a + b;
	a = a % 3;

	int b = a && c;
	int bb = b || (c == -c) && (!a);

	// This is single line comment
	int k = 1 * x + 6;
	int x = k;
	int world = 45;
  
    return 0;
}