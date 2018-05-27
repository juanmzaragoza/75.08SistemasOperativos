#!/bin/bash

DIRLLEGADA="./llegada" #"$HOME/llegada"
DIRVALIDADOS="./validados" #"$HOME/validados"
DIRERROR="./error" #"$HOME/error"
OPT=$1

for nameFile in $DIRLLEGADA/*
do

	if [ -r "$nameFile" ] # tengo permisos de lectura
	then

		FILIAL=`echo "$nameFile" | sed "s|^.*\/\(.*\)\.[0-2][0-9][0-9][0-9][0-1][0-9]$|\1|"`
		RESULT=`grep "^$FILIAL;.*;.*$" filial.TXT`

		if [ -z "$RESULT" ] # no se encontro la filial
		then
			echo "No se encuentra la filial $FILIAL en $nameFile"
			cp "$nameFile" "$DIRERROR"
		else # filial valida
			MES=`echo "$nameFile" | sed "s|.*.\([0-2][0-9][0-9][0-9][0-1][0-9]\)$|\1|"`
			#if (( $MES < 201710 )) # mes invalido
			if [[ "$MES" -lt 201710 ]] # es lo mismo que lo que esta arriba
			then
				echo "Mes $MES invalido para la $FILIAL en $nameFile"
				cp "$nameFile" "$DIRERROR"
			else # mes valido
				
				ERROR=0
				while read -r line
				do
					PRODUCTOID=`echo "$line" | sed "s|^\(.*\);.*;.*;.*$|\1|"`
					CANTIDAD=`echo "$line" | sed "s|^.*;\(.*\);.*;.*$|\1|"`

					RESULT=`grep "^$PRODUCTOID;.*;.*$" productos.TXT`
					if [[ -z "$RESULT" ]] # producto no existe
					then
						echo "Producto $PRODUCTOID invalido en linea $line de $nameFile"
						cp "$nameFile" "$DIRERROR"
						ERROR=1
						break
					else # producto existe
						if [[ "$OPT" == "-m" ]] # opcion -m
						then
							PRODUCCIONMINIMA=`grep "^$PRODUCTOID;.*;.*$" productos.TXT | sed "s|^$PRODUCTOID;.*;\(.*\)$|\1|"`
							if (( $PRODUCCIONMINIMA >= $CANTIDAD ))
							then 
								echo "La produccion $CANTIDAD en la linea $line es menor $PRODUCCIONMINIMA en $nameFile"
								cp "$nameFile" "$DIRERROR"
								ERROR=1
								break
							fi
						fi

					fi
				done < "$nameFile"

				if (( $ERROR == 0 ))
				then
					echo "Archivo $nameFile VALIDO"
					cp "$nameFile" "$DIRVALIDADOS"
				fi # FIN ARCHIVO VALIDO

			fi # FIN MES VALIDO
		fi # FIN FILIAL VALIDA
	else # sin permisos de lectura
		echo "No tengo permisos de lectura para $nameFile"
		cp "$nameFile" "$DIRERROR"
	fi
done