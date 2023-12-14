simpleLang:  simpleLang.o lexico.o
	gcc simpleLang.o lexico.o -o simpleLang
simpleLang.o: simpleLang.c
	gcc -c simpleLang.c -o simpleLang.o
simpleLang.c:  simpleLang.y
	bison -d -osimpleLang.c simpleLang.y
lexico.o: lexico.c
	gcc -c lexico.c -o lexico.o
lexico.c: lexico.l
	flex -olexico.c  lexico.l
clean: 
	rm *.o  simpleLang *.c
