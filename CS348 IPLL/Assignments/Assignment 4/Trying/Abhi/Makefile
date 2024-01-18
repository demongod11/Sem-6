test: a.out
	./a.out < ass4_19CS10031_19CS10051_test.c > output.txt

a.out: lex.yy.o y.tab.o ass4_19CS10031_19CS10051.o
	gcc lex.yy.o y.tab.o ass4_19CS10031_19CS10051.o -lfl

ass4_19CS10031_19CS10051.o: ass4_19CS10031_19CS10051.c
	gcc -c ass4_19CS10031_19CS10051.c

lex.yy.o: lex.yy.c
	gcc -c lex.yy.c

y.tab.o: y.tab.c
	gcc -c y.tab.c

lex.yy.c: ass4_19CS10031_19CS10051.l y.tab.h
	flex ass4_19CS10031_19CS10051.l

y.tab.c: ass4_19CS10031_19CS10051.y
	yacc -dtv ass4_19CS10031_19CS10051.y -Wnone

y.tab.h: ass4_19CS10031_19CS10051.y
	yacc -dtv ass4_19CS10031_19CS10051.y -Wnone

ass4_19CS10031_19CS10051.c:
	touch ass4_19CS10031_19CS10051.c

clean:
	rm lex.yy.c y.tab.c y.tab.h lex.yy.o y.tab.o ass4_19CS10031_19CS10051.o y.output a.out
 