output.txt: a.out ass3_19CS10031_19CS10051_test.c
	./a.out < ass3_19CS10031_19CS10051_test.c > output.txt

a.out: lex.yy.c ass3_19CS10031_19CS10051.o 
	gcc ass3_19CS10031_19CS10051.o -lfl

lex.yy.c: ass3_19CS10051_19CS10031.l
	flex ass3_19CS10051_19CS10031.l

ass3_19CS10031_19CS10051.o: ass3_19CS10031_19CS10051.c
	gcc -c ass3_19CS10031_19CS10051.c 

clean: *
	rm output.txt lex.yy.c a.out *.o