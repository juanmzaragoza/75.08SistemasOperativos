#! /bin/bash
# ******************************************************************
# Universidad de Buenos Aires
# Facultad de Ingenieria
#
# 75.08 Sistemas Operativos
# Catedra Ing. Osvaldo Clua
#
#
# Ejemplo de Comportamiento de un ciclo for para lectura de un achivo
#
# Autor: Lic. Adrian Muccio
#
# ******************************************************************


#Creeo archivo input
echo "La segunda línea esta vacia

Esta es una linea normal" > input_for.dat

echo "Comienzo $0"
echo '<<<<<<<<<<<'

IFS=$'\n'   # Modifico Internal Field Separator

for linea in $(<input_for.dat)
do
    echo $linea
done  
echo '>>>>>>>>>>>'

