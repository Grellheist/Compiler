%{
#include <stdio.h>
%}

%token PROGRAMA CAR INT RETORNE LEIA ESCREVA NOVALINHA SE ENTAO SENAO ENQUANTO EXECUTE
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
         ;

%%

int main() {
    yyparse();
    return 0;
}

