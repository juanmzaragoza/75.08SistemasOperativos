#!/bin/bash

# Realizar un shell script que, dado un número pasado por parámetro, indique si
# es o no divisible entre 101. Si no se proporciona un número debe mostrar como
# usar el programa

if [ "$#" -lt 1 ];
then
	echo "ERROR: use mode: $ $0 102"
else
	b=`echo $1%101 | bc`
	if [ $b -eq "0" ];
	then
		echo "Divisible por 101"
	else 
		echo "No divisible por 101"
	fi
fi