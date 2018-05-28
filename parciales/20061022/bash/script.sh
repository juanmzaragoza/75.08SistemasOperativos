#/bin/bash

ARCHIVOSPROCESADOS=0
CANTIDADREGISTROS=0
if [ "$#" -lt 1 ]
then
	echo "Debe ingresar por lo menos un parametros aaaamm"
else
	for p in $@
	do
		RESULT=`echo "$p" | grep "^[0-2][0-9][0-9][0-9][0-1][0-9]$"`
		if [ -z "$RESULT" ]
		then
			echo "Formato de entrada $p invalido"
		else

			NOMBREARCHIVO="Prestamos.$p.txt"
			# si formato valido, corroboro que exista el archivo
			if [ ! -f "$NOMBREARCHIVO" ]
			then
				echo "No existe el archivo $NOMBREARCHIVO"
			else

				#proceso archivo
				while read -r line
				do
					# Prestamos.*
					CODIGOCLIENTE=`echo $line | sed "s/^\(.*\);.*;.*;.*$/\1/"`
					LINEACREDITO=`echo $line | sed "s/^.*;.*;\(.*\);.*$/\1/"`
					IMPORTESOLICITADO=`echo $line | sed "s/^.*;.*;.*;\(.*\)$/\1/"`

					LINEA=`grep "^$LINEACREDITO;[0-9][0-9],[0-9][0-9];[0-9]*;[0-9]*$" "Lineas.txt"`
					if [ ! -z "$LINEA" ] #si tengo alguna linea -> evito nulos
					then
						# Lineas.txt
						TASAVIGENTE=`echo "$LINEA" | sed "s/^$LINEACREDITO;\([0-9][0-9],[0-9][0-9]\);[0-9]*;[0-9]*$/\1/" | sed "s/,/./"`
						PLAZO=`echo "$LINEA" | sed "s/^$LINEACREDITO;[0-9][0-9],[0-9][0-9];\([0-9]*\);[0-9]*$/\1/"`
						IMPORTEMAXIMO=`echo "$LINEA" | sed "s/^$LINEACREDITO;[0-9][0-9],[0-9][0-9];[0-9]*;\([0-9]*\)$/\1/"`

						INTERESES=`echo "$IMPORTESOLICITADO * $TASAVIGENTE" | bc`
						INTERESES=`echo "$INTERESES * $PLAZO" | bc`

						echo "$LINEACREDITO;$CODIGOCLIENTE;$INTERESES;$IMPORTEMAXIMO" >> "informe.txt"
						CANTIDADREGISTROS=`echo "$CANTIDADREGISTROS+1" | bc`
					fi

				done < "$NOMBREARCHIVO" #fin proceso archivo

				ARCHIVOSPROCESADOS=`echo "$ARCHIVOSPROCESADOS+1" | bc`
			fi

		fi
	done

	echo "Archivos procesados: $ARCHIVOSPROCESADOS"
	echo "Cantidad de registros totales procesados: $CANTIDADREGISTROS"
fi