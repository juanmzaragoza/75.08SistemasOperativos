#!/bin/bash

DIR="legajos"
CODIGOCARGO=$1

DESCRIPCIONCARGO=`grep "^$CODIGOCARGO;.*$" CARGOS.txt | sed "s/^$CODIGOCARGO;\(.*\)$/\1/"`
if [ -z "$CODIGOCARGO" ]
then
	echo "Debe ingresar un codigo de cargo como parametros"
	exit 1
elif [ -z "$DESCRIPCIONCARGO" ]
then
	echo "Codigo de cargo incorrecto"
	exit 1
fi

echo "Informe"
echo "$CODIGOCARGO - $DESCRIPCIONCARGO"
for fileName in $DIR/*
do
	SUCURSAL=`echo "$fileName" | sed "s|.*\/legajos_\([0-9][0-9]*\)$|\1|"`
	while read -r line
	do
		RESULTADO=`echo $line | grep "^.*;.*;$CODIGOCARGO;.*;.*$"`
		if [ ! -z "$RESULTADO" ]
		then
			LEGAJO=`echo $line | sed "s|^\(.*\);.*;.*;.*;.*$|\1|"`
			NOMBREYAPELLIDO=`echo $line | sed "s|^.*;.*;.*;\(.*\);.*$|\1|"`
			echo "$LEGAJO - $NOMBREYAPELLIDO - $SUCURSAL"
		fi
	done < "$fileName"
done


