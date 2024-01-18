ass4_19CS30005_19CS10065.txt: a.out ass4_19CS30005_19CS10065_test.c
	./a.out < ass4_19CS30005_19CS10065_test.c > ass4_19CS30005_19CS10065.txt

a.out: lex.yy.o ass4_19CS30005_19CS10065.o y.tab.o
	gcc lex.yy.o ass4_19CS30005_19CS10065.o y.tab.o -lfl 

lex.yy.c: ass4_19CS30005_19CS10065.l y.tab.h
	flex ass4_19CS30005_19CS10065.l

y.tab.c: ass4_19CS30005_19CS10065.y 
	bison -dty ass4_19CS30005_19CS10065.y --report=solved

ass4_19CS30005_19CS10065.o: ass4_19CS30005_19CS10065.c 
	gcc -c ass4_19CS30005_19CS10065.c 

y.tab.h: ass4_19CS30005_19CS10065.y
	bison -dty ass4_19CS30005_19CS10065.y --report=solved

lex.yy.o: lex.yy.c 
	gcc -c lex.yy.c 

y.tab.o: y.tab.c 
	gcc -c y.tab.c

clean:
	rm a.out lex.yy.* y.output ass4_19CS30005_19CS10065.o y.tab.* 
