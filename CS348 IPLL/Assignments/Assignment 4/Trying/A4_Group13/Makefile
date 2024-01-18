test: a.out
	./a.out < A4_Group13.nc > output.txt

a.out: lex.yy.o y.tab.o A4_Group13.o
	gcc lex.yy.o y.tab.o A4_Group13.o -lfl

A4_Group13.o: A4_Group13.c
	gcc -c A4_Group13.c

lex.yy.o: lex.yy.c
	gcc -c lex.yy.c

y.tab.o: y.tab.c
	gcc -c y.tab.c

lex.yy.c: A4_Group13.l y.tab.h
	flex A4_Group13.l

y.tab.c: A4_Group13.y
	yacc -dtv A4_Group13.y -Wnone

y.tab.h: A4_Group13.y
	yacc -dtv A4_Group13.y -Wnone

A4_Group13.c:
	touch A4_Group13.c

clean:
	rm lex.yy.c y.tab.c y.tab.h lex.yy.o y.tab.o A4_Group13.o y.output a.out
 