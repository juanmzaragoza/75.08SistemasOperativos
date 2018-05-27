#!/bin/bash

ARRIBOSDIR="arribos" # $HOME/arribos
ERRORESDIR="errores" # /errores
MAEDIR="mae" # /mae
RESULTADOSDIR="resultados" # /resultados

# recorro todos los arribos
for arriboFileName in $ARRIBOSDIR/* 
do
	# corroboro formato
	FORMATO=`echo ${arriboFileName##*/} | grep "^.*\.[0-2][0-9]\{3\}[0-2][0-9]\.txt$"`
	if [ -z "$FORMATO" ]
	then
		echo "Mover ${arriboFileName##*/} a $ERRORESDIR"
		# mv "$arriboFileName" "$ERRORESDIR"
		continue
	fi

	while read -r lineaArribo # recorro todas las lineas del archivo de arribo
	do
		NUMEROFACTURA=`echo $lineaArribo | sed "s|^\(.*\),.*,.*,.*$|\1|"`
		IDMODEM=`echo $lineaArribo | sed "s|^.*,\(.*\),.*,.*$|\1|"`
		FECHA=`echo $lineaArribo | sed "s|^.*,.*,\(.*\),.*$|\1|"`
		CANTIDAD=`echo $lineaArribo | sed "s|^.*,.*,.*,\(.*\)$|\1|"`

		if [ "$CANTIDAD" -gt 10 ] # si la cantidad es mayor a 10
		then
			echo "La cantidad $CANTIDAD de $lineaArribo es mayor a 10"
			echo "$lineaArribo" >> "$ERRORESDIR/errores.txt"
			continue
		fi

		lineaModem=`grep "^$IDMODEM,.*,.*,.*$" "$MAEDIR/MODEMS.DAT"`
		if [ -z "$lineaModem" ] # no hay modem con ese id
		then
			echo "No existe modem $IDMODEM en $lineaArribo"
			echo "$lineaArribo" >> "$ERRORESDIR/errores.txt"
			continue
		fi

		IMPORTE=`echo "$lineaModem" | sed "s/^$IDMODEM,.*,.*,\(.*\)$/\1/"` # supongo un modem unico por linea
		IDGAMA=`echo "$lineaModem" | sed "s/^$IDMODEM,.*,\(.*\),.*$/\1/"` # supongo un modem unico por linea

		lineaGama=`grep "^$IDGAMA,.*,.*$" "$MAEDIR/GAMA.DAT"`
		if [ -z "$lineaGama" ] # no hay gama con ese id
		then
			echo "No existe gama $IDGAMA en $lineaArribo"
			echo "$lineaArribo" >> "$ERRORESDIR/errores.txt"
			continue
		fi

		DESCUENTO_GAMA=`echo "$lineaGama" | sed "s/^$IDGAMA,.*,\(.*\)$/\1/"`

		# calculo importe total
		IMPORTE_TOTAL=`echo "$IMPORTE * $DESCUENTO_GAMA" | bc`
		IMPORTE_TOTAL=`echo "$IMPORTE_TOTAL * $CANTIDAD" | bc`

		# guardo resultado
		echo "$NUMEROFACTURA|$IDMODEM|$FECHA|$IMPORTE_TOTAL" >> "$RESULTADOSDIR/facturas.txt"

	done < "$arriboFileName" # fin recorrer lineas archivo arribo

done
