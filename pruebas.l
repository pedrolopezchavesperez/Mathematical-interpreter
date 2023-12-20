%{
        #include "TS.h"
        #include <stdio.h>
        #include "ejemplo.tab.h"

        int abiertos = 0;
        int escape = 0;
%}

%option nounput
%option noinput

DIGITO  [0-9]
ID      ([a-zA-Z]|_)([a-zA-Z0-9]*[a-zA-Z0-9_])?
BINARIO  0[bB][01]+
FLOAT  {DIGITO}+"."{DIGITO}+
NOTACION ({FLOAT}|({DIGITO}+))(e|E)([+|-])?{DIGITO}+
NUMEROS_GRANDES ([0-9]+_[0-9]+)+
%x COMENTARIO_A
%x STRINGS

%%

{DIGITO}+   {return(INT);}     /* ENTEROS*/
{BINARIO} {return(BINARY);}     /* ENTEROS BINARIOS*/
{FLOAT}  {return(FLOAT);}     /* ENTEROS BINARIOS*/
{NOTACION}  {return(INT);}     /* ENTEROS BINARIOS*/
{ID}+   {return(IDENTIFICADOR);}  /* IDENTIFICADORES*/
{NUMEROS_GRANDES}  {return(INT);}  /* NUMEROS GRANDES*/
"//"(.)*?\n    { /* IGNORAR EL COMENTARIO DE UNA LINEA */ }
\/\*[^*]*\*+([^/*][^*]*\*+)*\/  { /* IGNORAR EL COMENTARIO DE BLOQUE */ }

"/+"   {BEGIN(COMENTARIO_A); abiertos++;}  /* COMENTARIO ANIDADO*/
<COMENTARIO_A>{
        "/+"   {BEGIN(COMENTARIO_A); abiertos++;}  /* COMENTARIO ANIDADO*/
        "+/"   {BEGIN(COMENTARIO_A); abiertos--; if (abiertos == 0) BEGIN(INITIAL);}  /* COMENTARIO ANIDADO*/
        "\n"   {}  /* IGNORAR EL COMENTARIO*/
        .   {;}  /* IGNORAR EL COMENTARIO*/
}

\"([^\"\\]|\\(.|\n))*\"  {return(STRING);}  /* STRING*/

"("   {return(40);}  /* PARENTESIS DE APERTURA*/

")"   {return(41);}  /* PARENTESIS DE CIERRE*/

"{"   {return(123);}  /* LLAVE DE APERTURA*/

"}"   {return(125);}  /* LLAVE DE CIERRE*/

"["   {return(91);}  /* CORCHETE DE APERTURA*/

"]"   {return(93);}  /* CORCHETE DE CIERRE*/

"="   {return(61);}  /* SIGNO DE IGUAL*/

"=="   {return(EQ_EQ);}  /* SIGNO DE IGUAL*/

"!="   {return(NOT_EQ);}  /* SIGNO DE DIFERENTE*/

"<"   {return('<');}  /* SIGNO DE MENOR QUE*/

"<="   {}  /* SIGNO DE MENOR O IGUAL QUE*/

">"   {}  /* SIGNO DE MAYOR QUE*/

">="   {}  /* SIGNO DE MAYOR O IGUAL QUE*/

"+"   {return('+');}  /* SIGNO DE SUMA*/

"++"   {return(INC);}  /* SIGNO DE INCREMENTO*/

"-"   {return('-');}  /* SIGNO DE RESTA*/

"--"   {return(DEC);}  /* SIGNO DE DECREMENTO*/

"*"   {return('*');}  /* SIGNO DE MULTIPLICACION*/

"%"   {return('%');}  /* SIGNO DE MODULO*/

"&&"   {return(AND);}  /* SIGNO DE AND*/

"||"   {return(OR);}  /* SIGNO DE OR*/

"!"   {return('!');}  /* SIGNO DE NOT*/

";"   {return(';');}  /* SIGNO DE PUNTO Y COMA*/

","   {return(',');}  /* SIGNO DE COMA*/

"/"   {return('/');}  /* SIGNO DE DIVISION*/

"\n"   {}  /* IGNORAR*/

"\t"   {}  /* IGNORAR*/

" "   {}  /* IGNORAR*/

"."   {return('.');}  /* SIGNO DE PUNTO*/

%%

int yywrap() {
    return 1;
}

void abrirFichero(char* fichero){
 if((yyin = fopen(fichero, "r")) == NULL) perror("No se pudo abrir el fichero.\n");
}

void cerrarFichero(){
 fclose(yyin);
 yylex_destroy();
}

int siguienteComponenteLexico(char *mensaje){
        int token = yylex();
        strcpy(mensaje, yytext);
        yytext[0]='\0';
        if(token == 400)
                token=buscarTS(mensaje);
        return token;
}
