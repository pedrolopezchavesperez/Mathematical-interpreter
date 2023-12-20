#ifndef PRACTICA1_TS_H
#define PRACTICA1_TS_H
#include "define.h"

void insert(char *mensaje, int value);// Función para insertar una clave y su valor asociado en la tabla de hash
int buscarTS(char *key);// Función para buscar un valor en la tabla de hash a partir de su clave
void freeHashTable();// Función para liberar la memoria reservada para la tabla de hash
void crearTabla();// Funcion que inicializa e inserta los valores en la tabla de hash

#endif //PRACTICA1_TS_H