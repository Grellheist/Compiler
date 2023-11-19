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

statement: CAR       { printf("Achei a palavra reservada: CAR\n"); }
         | INT       { printf("Achei a palavra reservada: INT\n"); }
         | RETORNE   { printf("Achei a palavra reservada: RETORNE\n"); }
         | LEIA      { printf("Achei a palavra reservada: LEIA\n"); }
         | ESCREVA   { printf("Achei a palavra reservada: ESCREVA\n"); }
         | NOVALINHA { printf("Achei a palavra reservada: NOVALINHA\n"); }
         | SE        { printf("Achei a palavra reservada: SE\n"); }
         | ENTAO     { printf("Achei a palavra reservada: ENTAO\n"); }
         | SENAO     { printf("Achei a palavra reservada: SENAO\n"); }
         | ENQUANTO  { printf("Achei a palavra reservada: ENQUANTO\n"); }
         | EXECUTE   { printf("Achei a palavra reservada: EXECUTE\n"); }
         | ID        { printf("Achei o ID: %s\n", $1); }
         | STRING    { printf("Achei a STRING: %s\n", $1); }
         | NUMBER    { printf("Achei o NUMERO: %s\n", $1); }
         ;

%%

void yyerror(const char *msg) {
    fprintf(stderr, "ERRO: %s na linha %d, coluna %d, token: %s\n", msg, yylineno, (int)(strlen(yytext)), yytext);
    fprintf(stderr, "Context: ");
    for (int i = 0; i < 5; i++) {
        yylex(); 
        fprintf(stderr, "%s ", yytext);
    }
    fprintf(stderr, "\n");
    exit(1);
}

int main() {
    yyparse();
    return 0;
}

