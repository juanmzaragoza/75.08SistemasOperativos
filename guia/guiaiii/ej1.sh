#!/bin/bash

# 1 Capicúas
# Se tiene un archivo con números enteros de 3 dígitos, se desea generar otro archivo con los
# capicúas de cada uno de los números

sed "s/\([0-9]\)\([0-9]\)\([0-9]\)/\1\2\3\2\1/" > ej1-result.txt
