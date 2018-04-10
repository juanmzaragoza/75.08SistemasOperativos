#! /bin/bash
# ******************************************************************
# Universidad de Buenos Aires
# Facultad de Ingenieria
#
# 75.08 Sistemas Operativos
# Catedra Ing. Osvaldo Clua
#
#
# Ejemplo de Comportamiento de un ciclo while para lectura de un achivo
# Autor: Lic. Adrian Muccio
#
# ******************************************************************


#Creeo archivo input
echo "La segunda línea esta vacia

Esta es una linea con backslash \n
Esta es una linea con comodines *" > input_while.dat

echo "Comienzo $0"
echo "<<<<<<<<<<<"

while read linea
do
    echo $linea
done < input_while.dat

echo ">>>>>>>>>>>"

