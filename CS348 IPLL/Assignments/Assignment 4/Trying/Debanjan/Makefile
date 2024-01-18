asgn4_19CS10048_19CS30014.txt: a.out asgn4_19CS10048_19CS30014_test.c
	./a.out < asgn4_19CS10048_19CS30014_test.c > asgn4_output_19CS10048_19CS30014.txt

a.out: lex.yy.o asgn4_19CS10048_19CS30014.o y.tab.o
	gcc lex.yy.o asgn4_19CS10048_19CS30014.o y.tab.o -lfl  

lex.yy.c: asgn4_19CS10048_19CS30014.l y.tab.h
	flex asgn4_19CS10048_19CS30014.l

y.tab.h: asgn4_19CS10048_19CS30014.y
	bison -dty asgn4_19CS10048_19CS30014.y --report=all

y.tab.c: asgn4_19CS10048_19CS30014.y
	bison -dty asgn4_19CS10048_19CS30014.y --report=all

asgn4_19CS10048_19CS30014.o: asgn4_19CS10048_19CS30014.c 
	gcc -W -c asgn4_19CS10048_19CS30014.c 

lex.yy.o: lex.yy.c 
	gcc -W -c lex.yy.c 

y.tab.o: y.tab.c 
	gcc -W -c y.tab.c

clean:
	rm a.out lex.yy.* y.* asgn4_19CS10048_19CS30014.o
