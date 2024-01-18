static a1 = 0;
register a2 = 9;
static a3 = 12;
extern a4 = 34;

enum State {Working = 1, Failed = 2, Freezed = 3, Learning = 4, Learned = 5};

volatile int learn_Compilers(){
	return Learning;
}

const inline void genrate_marks(){
	int t = learn_Compilers();
	t = t * 2;
}
int getMarks(){
	genrate_marks();
	return 100;
}
int main(){
	int n, array[2000];
	int c, d, t;
	signed a = array[0];

	for (int i = 0; i < n; i++){
		// a &=34;
		// running a loop
	}
	for (;;){
		break;
		continue;
		//loop with empty
	}

	for (c = n - 1; c >= 0; c--){
		d += c;

		while (d > 0 && array[d - 1] > array[d]){
			t = array[d];
			array[d] = array[d - 1];
			array[d - 1] = t;

			d--;
		}
	}
	int alpha = 67.4;
	float b = 23;
	double gandhi = 23.0;
	unsigned sajal = b;
	a = b + 45;
	int z = a;
	for (c = 0; c <= n - 1; c++){
		if(sajal == gandhi)
			return 100;
		goto loop;
	}

	// checking operations
	int *x = &a;
	x->a;
	*x.a;
	a++;
	b--;
	b = ++a;
	b = a++;
	a = b--;
	a = --b;

	a = (int)b & 1;
	a = a | 1;
	a = a ^ 2;
	a = !a;
	a = a * c;
	a = a / b;
	a = a + b;
	a = a % 3;
	a += 2;
	b -= 3;
	c *= d;
	c /= 5;
	c %= 1;
	c <<= 2;
	c >>= z;
	c &= 2;
	c |= 1;
	c ^= 0;
	int b = a && c;
	int bb = b || (c == -c) && (!a);

	&a; *a; +a; -a; ~a; ! a;

	// This is single line comment
	_Bool hello = 0;
	_Complex kitty = 1 * x + 6;
	_Imaginary x = kitty;
	long world = 45;

	hello += world;
	hello -= kitty;
	for (short toysssssss = 0; toysssssss < 45; toysssssss++){
		int dog = toysssssss; // animals
	}
}

restrict void making_useless_functions(int no_work, int time_pass){
	while (no_work){
		time_pass++;
	}
	return a1;
}