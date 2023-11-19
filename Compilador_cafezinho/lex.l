%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h"
%}

%option noyywrap

numeros ([0-9])+
letras [a-zA-Z]
id [a-zA-Z_][a-zA-Z0-9_]*
string (\"[^\"\n]*\")


%%

programa   { return PROGRAMA; }
car        { return CAR; }
int        { return INT; }
retorne    { return RETORNE; }
leia       { return LEIA; }
escreva    { return ESCREVA; }
novalinha  { return NOVALINHA; }
se         { return SE; }
entao      { return ENTAO; }
senao      { return SENAO; }
enquanto   { return ENQUANTO; }
execute    { return EXECUTE; }

{id}  { yylval.str = strdup(yytext); return ID; }
{numeros}      { yylval.str = strdup(yytext); return NUMBER; }
{string} { yylval.str = strdup(yytext); return STRING; }

"/*"        { 
             while(1) {
                char c = getchar();
                if (c == EOF) {
                    fprintf(stderr, "ERRO: COMENTARIO NAO TERMINA\n");
                    exit(1);
                } else if (c == '*' && getchar() == '/') {
                    break; 
                }
             }
           }

[ \t\n]      ; 

.           {
                fprintf(stderr, "ERRO: CARACTERE INVALIDO\n");
                exit(1);
            }

%%
