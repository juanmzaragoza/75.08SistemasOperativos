#!/bin/bash

NOVEDADESDIR="./novedades"
RECHAZADOSDIR="rechazados"
OKDIR="ok"
MAEDIR="mae"

if [ ! -f "$MAEDIR/oficina.dat" ]
then
	echo "No existe el archivo $MAEDIR/oficina.dat"
	exit 1
elif [ ! -f "$MAEDIR/clientes.dat" ]
then
	echo "No existe el archivo $MAEDIR/clientes.dat"
	exit 1
elif [ -z `ls $NOVEDADESDIR` ]
then
	echo "Directorio de novedades vacio"
	exit 1
fi

for fileName in $NOVEDADESDIR/*
do

	ISVALID=`echo "${fileName##*/}" | grep "^.*_[0-2][0-9][0-9][0-9][0-1][0-9]\.txt$"`

	if [ -z "$ISVALID" ]
	then
		echo "Formato nombre archivo invalido ${fileName##*/}"
		mv "$fileName" "$RECHAZADOSDIR"
		continue
	fi

	OFICINA=`echo "${fileName##*/}" | sed "s/^\(.*\)_[0-2][0-9][0-9][0-9][0-1][0-9]\.txt$/\1/" `
	ANOMES=`echo "${fileName##*/}" | sed "s/^.*_\([0-2][0-9][0-9][0-9][0-1][0-9]\)\.txt$/\1/" `
	OFICINAEXITS=`grep "^$OFICINA,.*,.*$" "$MAEDIR/oficina.dat"`

	if [ -z "$OFICINA" ] || [  -z "$ANOMES"  ]
	then
		echo "Mal formato de archivo ${fileName##*/}"
		mv "$fileName" "$RECHAZADOSDIR"
		continue
	elif [ "$ANOMES" -gt 201511 ]
	then
		echo "El mes $ANOMES es mayor a 2015"
		mv "$fileName" "$RECHAZADOSDIR"
		continue
	elif [ -z "$OFICINAEXITS" ]
	then
		echo "No existe oficina $OFICINA"
		mv "$fileName" "$RECHAZADOSDIR"
		continue
	fi

	ISVALID=0
	while read -r line
	do
		
		IDCLIENTE=`echo "$line" | grep "^.*|.*|.*$" | sed "s/^\(.*\)|.*|.*$/\1/"`
		CLIENTEVALIDO=`grep "^$IDCLIENTE,.*;.*$" "$MAEDIR/clientes.dat" `

		if [ -z "$IDCLIENTE" ]
		then
			echo "Formato de linea incorrecto $line"
			mv "$fileName" "$RECHAZADOSDIR"
			ISVALID=1
			break
		elif [ -z "$CLIENTEVALIDO" ]
		then
			echo "El cliente $IDCLIENTE no existe"
			mv "$fileName" "$RECHAZADOSDIR"
			ISVALID=1
			break
		fi

		if [ "$IDCLIENTE" == "$1" ]
		then
			MINUTOS=`echo "$line" | sed "s/^.*|\(.*\)|.*$/\1/"`
			CODIGODESTINO=`echo "$line" | sed "s/^.*|.*|\(.*\)$/\1/"`
			NOMBREYAPELLIDO=`sed "s/^$IDCLIENTE|\(.*\)|.*$/\1/"" "$MAEDIR/clientes.dat" `
			echo "$IDCLIENTE $NOMBREYAPELLIDO $MINUTOS $CODIGODESTINO"
		fi

	done < "$fileName"

	if "$ISVALID"
	then
		echo "Archivo valido: ${fileName##*/}"
		mv "$fileName" "$OK"
	fi

done