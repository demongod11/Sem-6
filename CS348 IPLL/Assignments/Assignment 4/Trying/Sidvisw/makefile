ass3_20CS10082_20CS30029_output.txt: a.out asgn4_20CS10082_20CS30029_test.c
	./a.out < asgn4_20CS10082_20CS30029_test.c > asgn4_20CS10082_20CS30029_output.txt

a.out: asgn4_20CS10082_20CS30029.o lex.yy.o y.tab.o
	g++ lex.yy.o y.tab.o asgn4_20CS10082_20CS30029.o -ll

asgn4_20CS10082_20CS30029.o: asgn4_20CS10082_20CS30029.c
	g++ -Wall -c asgn4_20CS10082_20CS30029.c

lex.yy.o: lex.yy.c
	g++ -c lex.yy.c

lex.yy.c: asgn4_20CS10082_20CS30029.l y.tab.h
	flex asgn4_20CS10082_20CS30029.l

y.tab.o: y.tab.c
	g++ -c y.tab.c

y.tab.c: asgn4_20CS10082_20CS30029.y
	yacc -dtv asgn4_20CS10082_20CS30029.y

y.tab.h: asgn4_20CS10082_20CS30029.y
	yacc -dtv asgn4_20CS10082_20CS30029.y

clean:
	rm asgn4_20CS10082_20CS30029.o lex.yy.o lex.yy.c y.tab.o y.tab.c y.tab.h y.output

distclean:
	rm asgn4_20CS10082_20CS30029_output.txt a.out asgn4_20CS10082_20CS30029.o lex.yy.o lex.yy.c y.tab.o y.tab.c y.tab.h y.output
