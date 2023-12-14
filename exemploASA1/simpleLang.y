%{
/*********** Este arquivo Define a implementação do esquema de traducaoo da figura 2.39, 
************ secao 2.8.2 doDragon book. */
#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include "tipos.h"
extern char * yytext;
extern int yylex();
extern int numLinha;
extern FILE* yyin;
extern int erroOrigem;
void yyerror( char const *s);
//Definicao de um no da arvore abstrata.

Toperador* CriaOperador(TespecieOperador tipoOperador,  int linha, Toperador* filho1, 
                        Toperador* filho2, char* lexema);
void percorreArvore(Toperador* raiz);
void obtemEspecieNoEnumLin(Toperador* no, char* nomeOperador);

Toperador* raiz;
char nomeOperador[200];



%}
/* Secao de definicoes para o Bison 
 define os simbolos usados na gramatica e tipos dos valores
 semanticos associados a cada simbolo (terminal e não terminal)*/

/* UNION para os valores da pilha semantica do YACC. Os elementos dessa pilha sao acessados através 
das referências $$, $1, ...Sn. Iremos construir a AST para a linguagem passando os enderecos dos nos da
arvore atraves da pilha semantica do parser gerado pelo YACC */
%union{
    int nlinha;
    Toperador* Tpont;
		char *numLexema;
}

/*
Cada elemento da pilha semântica e do tipo union acima. Isso significa que um elemento da pilha ora e um
int (linha), ora e um ponteiro para algum no da arvore, ora e um ponteiro para char
*/
%start  program /* Inidica que o simbolo incial da gramatica e programm */
%type<Tpont> block stmts stmt expr rel add term factor


%token IF WHILE DO LEQ <numLexema> NUM /* Definicao de terminais (que não são apenas caracteres), 
                                          com o uso da diretiva %token. Ha outras opcoes para definicao 
                                          de tokens (especificando ordem de associacao e 
			                              prescedencia de operadores -  ver secao 3.2 do manual do Bison*/

/* Pode haver mais de uma secao prologo e mais de uma secao de definicoes do Bison. 
   Estas secoes podem aparecer intercaladas entre si. Ver Secao 3.1.1 */

%%  /* Secao de regras - producoes da gramatica - Veja as normas de formação de produçoes na 
       secao 3.3 do manual */



program	: 	block                {raiz=$1;}
	;

block	: 	'{' stmts '}'        {$$=$2;}
	;

stmts 	:	stmt stmts           {$$=CriaOperador(lstStmt ,numLinha,$1,$2, NULL);}
        | /*cadeia vazia */          {$$=NULL;}
	;

stmt	:expr ';'		     {$$=$1;}
        |IF '(' expr ')' stmt        {$$=CriaOperador(If   ,numLinha,$3,$5, NULL);}
        |WHILE '(' expr ')' stmt     {$$=CriaOperador(While  ,numLinha,$3,$5, NULL); }
        |DO stmt WHILE '(' expr ')'  {$$=CriaOperador(Do ,numLinha,$2,$5, NULL); }
        |block              	     {$$=$1;}
	;

expr	:rel '=' expr         	     {$$=CriaOperador(Igual,numLinha,$1,$3, NULL);}
        | rel               	     {$$=$1;}
	;
rel	: rel  '<' add               {$$=CriaOperador(Menor, numLinha,$1,$3, NULL);}
        |rel LEQ add                 {$$=CriaOperador(MenorIgual, numLinha, $1,$3, NULL);}
        | add                        {$$=$1;}
	;
add	: add '+' term               {$$=CriaOperador(Mais , numLinha,$1,$3, NULL);} 
        | term              	     {$$=$1;}		
	;
term	: term '*' factor            {$$=CriaOperador(Mult, numLinha, $1,$3, NULL);} 
        | factor                     {$$=$1;}
	;
factor	: '(' expr ')'               {$$=$2;}
	| NUM                        {$$=CriaOperador(Num, numLinha,NULL, NULL,  $1);}
	;
%% /* Secao Epilogo*/	



int main(int argc, char** argv){
   if(argc!=2)
        yyerror("Uso correto: ./simpleLang nome_arq_entrada");
   yyin=fopen(argv[1], "r");
   if(!yyin)
        yyerror("arquivo não pode ser aberto\n");
    yyparse();
    percorreArvore(raiz);
    printf("\n");
}

void yyerror( char const *s) {
    if(erroOrigem==0) /*Erro lexico*/
    {
        printf("%s na linha %d - token: %s\n", s, numLinha, yytext);
    }
    else
    {
        printf("Erro sintatico proximo a %s ", yytext);
        printf(" - linha: %d \n", numLinha);
        erroOrigem=1;
    }
    exit(1);
}

void percorreArvore(Toperador* raiz){
    if(raiz){
        obtemEspecieNoEnumLin(raiz, nomeOperador);
        printf("%s ", nomeOperador);
        percorreArvore(raiz->filho1);
        percorreArvore(raiz->filho2);
        }
}


Toperador* CriaOperador(TespecieOperador tipoOperador, int linha, Toperador* filho1, 
                        Toperador* filho2, char* lexema){
    
    Toperador* aux = (Toperador*) malloc(sizeof(Toperador));
    if (aux){
        //printf("entrei aqui\n");
        aux->tipoOperador=tipoOperador;
        aux->linha=linha;
        aux->filho1=filho1;
        aux->filho2=filho2;
        if(lexema){
            aux->lexema= (char*)malloc(strlen(lexema)+1);
            strcpy(aux->lexema, lexema);
        }
        return(aux);
    }
    return(NULL);
}

void obtemEspecieNoEnumLin(Toperador* no, char* nomeOperador){
    switch(no->tipoOperador){
        case lstStmt:
        strcpy(nomeOperador,"stmts");
        break;
        case If:
        sprintf(nomeOperador, "If - Lin: %d", no->linha);
        break;
        case While :
        sprintf(nomeOperador, "While - Lin: %d", no->linha);
        break;
        case Do:
        sprintf(nomeOperador, "Do - Lin: %d", no->linha);
        break;
        case Num :
        sprintf(nomeOperador, "%s - Lin: %d", no->lexema,no->linha);
        break;
        case Mais:
        sprintf(nomeOperador, "+ - Lin: %d", no->linha);
        break;
        case Mult:
        sprintf(nomeOperador, "* - Lin: %d", no->linha);
        break;
        case Menor:
        sprintf(nomeOperador, "< - Lin: %d", no->linha);
        break;
        case Igual:
        sprintf(nomeOperador, "= - Lin: %d", no->linha);
        break;
        case MenorIgual:
        sprintf(nomeOperador, "<= - Lin: %d", no->linha);
        break;
    }
}
