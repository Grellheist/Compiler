%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Redefine YYSTYPE to include the necessary fields */
#define YYSTYPE_IS_DECLARED
typedef struct {
    char *str;
} YYSTYPE;

extern YYSTYPE yylval; // Declares the union variable

void yyerror(const char *msg);

%}

/* Define tokens */
%token <yystype> PROGRAMA CAR INT RETORNE LEIA ESCREVA NOVALINHA SE ENTAO SENAO ENQUANTO EXECUTE ID STRING NUMBER

%start program

%%

program: PROGRAMA statement_list
        ;

statement_list: /* empty */
              | statement_list statement
              ;

statement: CAR
         | INT
         | RETORNE
         | LEIA
         | ESCREVA
         | NOVALINHA
         | SE
         | ENTAO
         | SENAO
         | ENQUANTO
         | EXECUTE
         | ID       { printf("ID: %s\n", $1.str); }
         | STRING   { printf("STRING: %s\n", $1.str); }
         | NUMBER   { printf("NUMBER: %s\n", $1.str); }
         ;

%%

void yyerror(const char *msg) {
    fprintf(stderr, "ERRO: %s na linha %d\n", msg, yylineno);
    exit(1);
}

int main() {
    yyparse();
    return 0;
}

