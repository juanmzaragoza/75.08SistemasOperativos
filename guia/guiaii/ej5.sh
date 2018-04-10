#!/bin/bash

# Realizar un shell script que dado una lista de directorios, cree un archivo tar
# comprimido con gzip con nombre igual a la fecha en formato yyyy-mmdd.tar.gz.
# Además se generará un archivo yyyy-mm-dd.lst con los nombres de
# los directorios contenidos en el archivo tar, UNO POR LINEA usando un bucle.
# Si el archivo lst existe, mostrar un error y terminar el programa. Si alguno de
# los elementos no es un directorio, mostrar un error y finalizar el programa.

if [ "$#" -lt 1 ];
then
	echo "ERROR: use mode: $ $0 dir1/ dir2/"
else
	DATE=`date +%Y-%m-%d`

	if [ -f "$DATE.lst" ]
	then
		echo "ERROR: $DATE.lst exists"
		exit 1
	fi

	gzip $@  > "$DATE.tar.gz"

	for i in $@
	do
		if [ -d "$i" ]
		then
			echo "$i" >> "$DATE.lst"
		else
			echo "ERROR: $i is not a directory"
			exit 1
		fi
	done
fi