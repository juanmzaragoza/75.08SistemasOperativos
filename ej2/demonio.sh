#!/bin/bash

LOOP_COUNT=1

if [ ! -d "$HOME/salida_ej2" ] # if dir doesn't exists, create him
then
 mkdir "$HOME/salida_ej2"
fi

while [ true ]
do
    while read -r linea
	do
    AUX=$(grep '^DIRABUS=' "$HOME/INICIO.dat" | head);
    LIST_PATH="/${AUX#*/}";
  done < "$HOME/INICIO.dat"

  LIST=`ls -l $LIST_PATH/*.txt 2>/dev/null`
	if [ -z "$LIST" ] # if files exists, save them
	then
		CONTENT_DIR="No content" # else, save a message
	else
    CONTENT_DIR=$(ls -l $LIST_PATH/*.txt)
	fi

    # wait a minute
    sleep 1

    # save into number loop number file
    echo $CONTENT_DIR > "$HOME/salida_ej2/$LOOP_COUNT"

    LOOP_COUNT=`expr $LOOP_COUNT + 1`
done
