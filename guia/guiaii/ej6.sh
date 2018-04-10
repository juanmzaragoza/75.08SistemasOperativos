#!/bin/bash

# Realizar un shell script que permita adivinar al usuario cual es su PID. El
# script pide un número al usuario y cada vez que lo haga debe indicar al usuario
# si el PID es mayor o menor que el número introducido. Cuando se adivina el 
# valor, se deben mostrar los intentos empleados

PID=`ps -ef | grep "[e]j6.sh" | awk '{print $2}' | head -n1`
echo $PID

if [ "$#" -lt 1 ];
then
	echo "ERROR: use mode: $ $0 1001"
else
	USER_IN=$1
	i=0
	while [ "$USER_IN" != "$PID" ]
	do
		VALUES[$i]=$USER_IN
		echo ""
		if [ "$USER_IN" -lt "$PID" ];
		then
			echo "Input a greater value"
		else
			echo "Input a lower value"
		fi

		read -p "Input a new value:" USER_IN
		i=`echo $i+1 | bc`
	done

	echo ""
	echo "[You have inputed]: "
	printf '%s\n' "${VALUES[@]}"; 

fi