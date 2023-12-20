#include <stdio.h>
#include <stdlib.h>
#include "TS.h"
#include "define.h"
#include "lex.yy.h"
#include "ejemplo.tab.h"

void sintactico();
void liberarMemoria();

int main() {
    //inicializa tabla de simbolos y los centinelas
    crearTabla();
    abrirFichero("regression.d");

    //llama al analizador sintactico
    //sintactico();
    yyparse();

    //vacia memoria cuando termina usar valgrind para qque nos diga si se libero correctamente la memoria
    liberarMemoria();
    cerrarFichero();

    exit(1);
}

/*void sintactico(){
    //se declara la variable que va a contener el componente lexico
    struct componenteLexico componente;

    //se reserva la memoria y se inicializa
    componente.nombre = (malloc)(sizeof(char) * 100);
    for (int i = 0; i < 100; i++) *(componente.nombre + i) = '\0';

    componente.valor = siguienteComponenteLexico(componente.nombre);
    while(componente.valor != 0){
    	//AQUI TENGO EN COMPONENTE VALOR AMBOS VALORES
        printf("<%s,%d>\n", componente.nombre, componente.valor);
        for (int i = 0; i < 100; i++) *(componente.nombre + i) = '\0';
        componente.valor = siguienteComponenteLexico(componente.nombre);
    }//se ejecuta hasta el fin de fichero

    //liberamos la memoria reservada
    free(componente.nombre);

    printf("\nFin de archivo\n");//ejecucion correcta
}*/

void liberarMemoria(){
    freeHashTable();
}
