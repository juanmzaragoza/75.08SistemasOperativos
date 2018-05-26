#!/bin/bash

# validar formato de archivos
for nameFile in ALQUILER/*
do

	COD_BARRIO=`echo "$nameFile" | grep "ALQUILER\/ALQ\..*\.txt$" | sed 's@ALQUILER\/ALQ\.\(.*\)\.txt$@\1@'`
	EXISTS=`grep "^$COD_BARRIO,.*,.*$" ./MAE/BARRIOS.dat`

	if [ -z "$EXISTS" ]
	then
		mv "$nameFile" "errores/"
	else

		# extraigo comision
		COMISION=`grep "^$COD_BARRIO,.*,.*$" ./MAE/BARRIOS.dat | sed "s/^$COD_BARRIO,.*,\(.*\)$/\1/"`

		# leo cada linea del archivo de alquileres
		while read -r line
		do
			#1,12,Av. La Plata 100,5000
			ID_INQUILINO=`echo $line | sed 's@^\(.*\),.*,.*,.*$@\1@'`
			MES_ALQUILER=`echo $line | sed 's@^.*,\(.*\),.*,.*$@\1@'`
			DIRECCION_ALQUILER=`echo $line | sed 's@^.*,.*,\(.*\),.*$@\1@'`
			IMPORTE_ALQUILER=`echo $line | sed 's@^.*,.*,.*,\(.*\)$@\1@'`

			if (( IMPORTE_ALQUILER <= 100 ))
			then
				echo "$ID_INQUILINO,$MES_ALQUILER,$DIRECCION_ALQUILER,$IMPORTE_ALQUILER,$nameFile" >> ERRORES.dat
			else
				COMISION_PORCENTAJE=`echo "scale=2;$COMISION/100" | bc`
				IMPORTE_COMISION=`echo "scale=2;$IMPORTE_ALQUILER*$COMISION_PORCENTAJE" | bc`
				echo "$ID_INQUILINO; $DIRECCION_ALQUILER;$IMPORTE_COMISION" >> COMISIONES.txt
			fi

		done < "$nameFile"
	fi
done