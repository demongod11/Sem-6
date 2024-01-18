
#include "stdio.h"
#include <math.h>

/*
Assignment 3 - Lexer for tiny C Test File
Group 2
19CS10031 - Abhishek Gandhi
19CS10051 - Sajal Chammunya 
*/

// Single line comment

//code like test case
struct Point
{
   int x, y;
} p1; 
int main(){   
	int n,i,a,b;
	scanf("%d",&n);
	for(int i=0; i<n;i++){
		auto t = n-i;
		if(t<0)
			break;
		t<<=2;
		a = t;
		t>>=2;
		b = t; 
		continue;
	}
	if ( a == b ){
		printf("a == b");
	}
	for(i=0;i<=10;i++){
		printf("%d", i);
	}
	_Complex a = 0*i+0;
	a = a*a;
	struct Point *x;
	x->x=0;
	x->y=0;
	_Bool var = true;
	return 0;
}


//exhaustive test case
auto
enum 
restrict 
unsigned
break 
extern 
return 
void
case 
float 
short 
volatile
char 
for 
signed 
while
const 
goto 
sizeof 
_Bool
continue 
if 
static 
_Complex
default 
inline 
struct 
_Imaginary
do 
int 
switch
double 
long 
typedef
else 
register 
union
int integer = 10000;
int a = 5;
int b = 5;
float flt = 51.6;
flt = .6;
flt = 12e13;
char var = 'k' ;
char *s = "string-literal"
[ ]
++
/
?
=
,
]
(
{ } . ->
* + - ~ !
% << >> < > <= >=
: ;
*= /= %= += -= <<=
#
--
)
&
==
>>=
!=
&=
^
|
^=
&&
||
|=
