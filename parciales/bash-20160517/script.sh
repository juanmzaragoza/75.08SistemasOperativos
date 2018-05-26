#!/bin/bash

YEAR=`date +%Y`
MONTH=`date +%m`
DAY=`date +%d`

fechaEsValida(){
	
	FILE=$1
	FILEYEAR=`echo "$FILE" | sed "s&^.*sol_fact_\([0-2][0-9]\{3\}\)[0-1][0-9][0-3][0-9]$&\1&"`
	FILEMONTH=`echo "$FILE" | sed "s&^.*sol_fact_[0-2][0-9]\{3\}\([0-1][0-9]\)[0-3][0-9]&\1&"`
	FILEDAY=`echo "$FILE" | sed "s&^.*sol_fact_[0-2][0-9]\{3\}[0-1][0-9]\([0-3][0-9]\)&\1&"`

	if (( $FILEYEAR > 2018 ))
	then
		return 1
	elif (( $FILEYEAR == 2018  & $FILEMONTH > $MONTH ))
	then
		return 1
	elif (( $FILEYEAR == 2018 & $FILEMONTH == $MONTH & $FILEDAY > $DAY ))
	then
		return 1
	elif (( $FILEYEAR < 2018  & $FILEMONTH <= 12 & $FILEMONTH >= 1 & $FILEDAY <= 30 & $FILEDAY >= 1  ))
	then
		return 0
	else
		return 1
	fi
}

procesarArchivo(){

	FILE=$1
	while read -r line
	do
		SERVICIO=`echo $line | sed "s/^\(.*\),.*,.*,.*,.*$/\1/"`
		REGION=`echo $line | sed "s/^.*,.*,.*,\(.*\),.*$/\1/"`
		CUENTA=`echo $line | sed "s/^.*,\(.*\),.*,.*,.*$/\1/"`
		IMPORTE=`echo $line | sed "s/^.*,.*,\(.*\),.*,.*$/\1/"`
		FECHA_VENC=`echo $line | sed "s/^.*,.*,.*,.*, \(.*\)$/\1/"`

		RESULTADO=`grep "^$SERVICIO,.*,$REGION,.*$" mae/segba.dat`
		PORCENTAJE=`grep "^$SERVICIO,.*,$REGION,.*$" mae/segba.dat | sed "s/^$SERVICIO,.*,$REGION,\(.*\)$/\1/g"`
		RESULTADOTARIFASOCIAL=`grep "^$CUENTA$" mae/tarifa_social.dat`

		porcentaje=0
		if [ -z "$RESULTADO" ]
		then
			mv "$FILE" "rechazados"
			break
		else
			if [ -z "$RESULTADOTARIFASOCIAL" ]
			then
				porcentaje=$PORCENTAJE
			fi

			PORCENTAJE_IMPORTE=$(( IMPORTE * PORCENTAJE ))
			NUEVO_IMPORTE=$(( IMPORTE + PORCENTAJE_IMPORTE ))
			echo "$SERVICIO,$CUENTA, $NUEVO_IMPORTE, $FECHA_VENC" >> "resultado/nueva_fact_$FILEYEAR$FILEMONTH$FILEDAY"
		fi

	done < "$FILE"
	return 0
}

for file in input/*
do
	FILE=`echo "$file" | grep "sol_fact_[0-2][0-9]\{3\}[0-1][0-9][0-3][0-9]$"`
	if fechaEsValida "$FILE"
	then
		
		procesarArchivo "$FILE"
		
	else
		mv "$FILE" "rechazados"
	fi 


done

