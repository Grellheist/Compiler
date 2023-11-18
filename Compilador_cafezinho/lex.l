%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h"
%}

%option noyywrap

%%

"programa"   { return PROGRAMA; }
"car"        { return CAR; }
"int"        { return INT; }
"retorne"    { return RETORNE; }
"leia"       { return LEIA; }
"escreva"    { return ESCREVA; }
"novalinha"  { return NOVALINHA; }
"se"         { return SE; }
"entao"      { return ENTAO; }
"senao"      { return SENAO; }
"enquanto"   { return ENQUANTO; }
"execute"    { return EXECUTE; }

[a-zA-Z_][a-zA-Z0-9_]*  { yylval = strdup(yytext); return ID; }
[0-9]+      { yylval = strdup(yytext); return NUMBER; }
\"[^\"\n]*\" { yylval = strdup(yytext); return STRING; }

"/*"        { /* Beginning of a comment */
             while(1) {
                char c = getchar();
                if (c == EOF) {
                    fprintf(stderr, "ERRO: COMENTARIO NAO TERMINA\n");
                    exit(1);
                } else if (c == '*' && getchar() == '/') {
                    break; // End of comment
                }
             }
           }

[ \t\n]      ; // Skip whitespace

.           {
                fprintf(stderr, "ERRO: CARACTERE INVALIDO\n");
                exit(1);
            }

%%

int main() {
    yylex();
    return 0;
}

