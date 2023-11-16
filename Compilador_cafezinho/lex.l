%{
#include "parser.tab.h"
%}

%%

programa    { printf("Encontrei: %s\n", yytext); return PROGRAMA; }
car         { printf("Encontrei: %s\n", yytext); return CAR; }
int         { printf("Encontrei: %s\n", yytext); return INT; }
retorne     { printf("Encontrei: %s\n", yytext); return RETORNE; }
leia        { printf("Encontrei: %s\n", yytext); return LEIA; }
escreva     { printf("Encontrei: %s\n", yytext); return ESCREVA; }
novalinha   { printf("Encontrei: %s\n", yytext); return NOVALINHA; }
se          { printf("Encontrei: %s\n", yytext); return SE; }
entao       { printf("Encontrei: %s\n", yytext); return ENTAO; }
senao       { printf("Encontrei: %s\n", yytext); return SENAO; }
enquanto    { printf("Encontrei: %s\n", yytext); return ENQUANTO; }
execute     { printf("Encontrei: %s\n", yytext); return EXECUTE; }

%%

int main() {
    yylex();
    return 0;
}

