#!/bin/bash

# 9 CANCIONES
# Dado una duración de canción pasada por parámetro con el siguiente formato (hh:mm:ss) indicar si
# es mayor o menor al límite establecido:
# LIMITE="00:03:12"

if [ -z $1 ]
then
	echo "invalid"
else
	
	RESULT1=`echo $1 | grep "^[^0]" | sed "s/.*/MAYOR/" `

	RESULT2=`echo $1 | grep "^0[^0]" | sed "s/.*/MAYOR/" `

	RESULT3=`echo $1 | grep "^00:[^0]" | sed "s/.*/MAYOR/" `

	RESULT4=`echo $1 | grep "^00:0[^0-3]" | sed "s/.*/MAYOR/" `

	RESULT5=`echo $1 | grep "^00:0[0-3]:[^0-1]" | sed "s/.*/MAYOR/" `

	RESULT6=`echo $1 | grep "^00:0[0-3]:[^0][^0-2]" | sed "s/.*/MAYOR/" `

	echo "$RESULT1 $RESULT2 $RESULT3 $RESULT4$RESULT5$RESULT6"


fi