CC = gcc
CFLAGS =   -o
LFLAGS = -lfl

cafezinho:   lex.yy.c  parser.tab.c
	$(CC) $(CFLAGS) cafezinho lex.yy.c parser.tab.c $(LFLAGS)
                
flex: lex.l
	flex lex.l

bison: parser.y  
	bison -d parser.y

tgz: 
	rm -f cafezinho parser.tab.* lex.yy.c lex *.tgz 
	tar -zcvf Lexico.tgz *
	echo "O arquivo Lexico.tgz com os fontes e Makefile foi gerado. Pode ser enviado."	
