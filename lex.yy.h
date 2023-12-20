#ifndef PRACTICA1_LEX_YY_H
#define PRACTICA1_LEX_YY_H
#include "define.h"
#include "TS.h"

int siguienteComponenteLexico(char *mensaje); //devuelve el valor del componente lexico y lo guarda en mensaje
void abrirFichero(char *fichero); //abre el fichero
void cerrarFichero(); //cierra el fichero y destruye las variables porpias de flex

#endif //PRACTICA1_LEX_YY_H
