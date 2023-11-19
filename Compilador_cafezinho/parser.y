%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern int yylineno;
extern char *yytext;

void yyerror(const char *msg);

%}

%union {
    char *str;
}

%token PROGRAMA CAR INT RETORNE LEIA ESCREVA NOVALINHA SE ENTAO SENAO ENQUANTO EXECUTE
%token <str> ID STRING NUMBER

%start program

%%

program: PROGRAMA statement_list
        ;

statement_list: /* empty */
              | statement_list statement
              ;

statement: CAR       { printf("Found keyword: CAR\n"); }
         | INT       { printf("Found keyword: INT\n"); }
         | RETORNE   { printf("Found keyword: RETORNE\n"); }
         | LEIA      { printf("Found keyword: LEIA\n"); }
         | ESCREVA   { printf("Found keyword: ESCREVA\n"); }
         | NOVALINHA { printf("Found keyword: NOVALINHA\n"); }
         | SE        { printf("Found keyword: SE\n"); }
         | ENTAO     { printf("Found keyword: ENTAO\n"); }
         | SENAO     { printf("Found keyword: SENAO\n"); }
         | ENQUANTO  { printf("Found keyword: ENQUANTO\n"); }
         | EXECUTE   { printf("Found keyword: EXECUTE\n"); }
         | ID        { printf("Found ID: %s\n", $1); }
         | STRING    { printf("Found STRING: %s\n", $1); }
         | NUMBER    { printf("Found NUMBER: %s\n", $1); }
         ;

%%

void yyerror(const char *msg) {
    fprintf(stderr, "ERRO: %s na linha %d, coluna %d, token: %s\n", msg, yylineno, (int)(strlen(yytext)), yytext);
    exit(1);
}

int main() {
    yyparse();
    return 0;
}

