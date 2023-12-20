%{
#include <stdio.h>
#include <stdlib.h>
#include "lex.yy.h"

void yyerror(char* s);
int yylex();

#define YYSTYPE double
#include <math.h>
%}

%token NUM

%%

input: /*vacio*/
    | input line
;
%%

void yyerror(char *s){
    printf("%s\n", s);
}