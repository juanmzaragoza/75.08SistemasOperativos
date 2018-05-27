#!/bin/bash

while read -r lineSucursal # leo archivo sucursales.dat
do
	SUCURSALID=`echo $lineSucursal | sed "s/^\(.*\),.*,.*$/\1/"`
	SUCURSALDESCRIPCION=`echo $lineSucursal | sed "s/^.*,\(.*\),.*$/\1/"`
	SUCURSALPROMEDIO=`echo $lineSucursal | sed "s/^.*,.*,\(.*\)$/\1/"`

	PRINT=0
	for fileSucursalName in sucursales/ventas-$SUCURSALID.*
	do

		if [ -f "$fileSucursalName" ] # si el archivo existe
		then
			
			if [ $PRINT -eq 0 ]
			then
				echo "$SUCURSALID - $SUCURSALDESCRIPCION"
				PRINT=1
			fi

			MES=`echo "${fileSucursalName##*/}" | sed "s/^ventas-$SUCURSALID\.\([0-9]\{6\}\)$/\1/"`
			IMPORTETOTAL=0
			while read -r line
			do
				IMPORTE=`echo "$line" | sed "s/^.*;.*;\(.*\);.*$/\1/"`
				IMPORTETOTAL=`echo "$IMPORTE + $IMPORTETOTAL" | bc`
			done < "$fileSucursalName"

			if [[ "$IMPORTETOTAL" -gt "$SUCURSALPROMEDIO" ]]
			then
				COMPARACION="MAYOR"
			elif [[ $IMPORTETOTAL -eq $SUCURSALPROMEDIO ]]
			then
				COMPARACION="IGUAL"
			else
				COMPARACION="MENOR"
			fi

			echo "$MES - $IMPORTETOTAL - $COMPARACION"

		fi
	done

done < "dat/sucursales.dat"