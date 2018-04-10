#!/bin/bash

# Realizar un shell script que dado un directorio pasado por parámetro, cree un
# archivo tar comprimido con gzip y con nombre igual a la fecha en formato
# yyyymmdd seguido de guión y seguido del nombre del directorio terminado en
# .tar.gz.
# Ejemplo: aplicado sobre home obtendríamos -? 2004-04-03-home.tar.gz.

if [ "$#" -lt 1 ] || [ ! -d "$1" ];
then
	echo "You must specify a valid directory"
else
	DATE_NOW=`date +%Y-%m-%d`

	DIR_PATH=`echo $1 | sed 's#/$##'`
	DIR_PATH=${DIR_PATH##*/}
	gzip -c "ej2.sh" > "$DATE_NOW-$DIR_PATH.tar.gz"
fi