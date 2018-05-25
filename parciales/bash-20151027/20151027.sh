#/bin/bash

if [ -z "$1" ]
then
	echo "Debe ingresar un directorio valido"
	exit 1
elif ! [ -r "$1" ]
then 
	echo "El directorio ingresado no tiene permisos de lectura"
	exit 1
fi

for fileName in $1/*
do

	if [ "$fileName" == "." ] || [ "$fileName" == ".." ]
	then
		continue
	else

		# chequear nombre valido
		validName=`echo "$fileName" | grep "AP_[0-9]\{6\}\.log"`
		validName2018=`echo "$validName" | grep "AP_20180[0-5]\.log"`
		validName2000=`echo "$validName" | grep "AP_20[0-1][0-7][0-1][0-9]\.log"`

		if ! [ -z "$validName2018" ] || ! [ -z "$validName2000" ]
		then # fromato valido

			# obtengo las aplicaciones validas
			VALIDAPP=`grep "^\(.*\), .*, 1$" "./mae/aplic.dat" | sed "s/^\(.*\), .*, 1$/\1/g"`

			for app in "$VALIDAPP"
			do
				cat "$fileName" | grep "^.*;ERROR;$app; .*$"
			done
		fi
	fi

done

