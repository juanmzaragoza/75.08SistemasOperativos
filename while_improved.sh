#! /bin/bash
# ******************************************************************
# Universidad de Buenos Aires
# Facultad de Ingenieria
#
# 75.08 Sistemas Operativos
# Catedra Ing. Osvaldo Clua
#
#
# Ejemplo de Comportamiento mejorado de un ciclo while para lectura de un achivo
#
# Autor: Lic. Adrian Muccio
#
# ******************************************************************

#Creeo archivo input
echo "La segunda línea esta vacia

Esta es una linea con backslash \n
Esta es una linea con comodines *" > input_while_improved.dat

echo "Comienzo $0"
echo "<<<<<<<<<<<"

#Ahora read con -r para considerar las contrabarras como parte de la linea
while read -r linea      
do
    echo "$linea"        # Ahora con comillas dobles
done < input_while_improved.dat

echo ">>>>>>>>>>"
