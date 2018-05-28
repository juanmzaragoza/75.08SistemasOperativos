#!/bin/bash

OUTPUTFOLDER="temp"

FILENAME=${1##*/}
OUTPUTFILENAME="$FILENAME-+-"

sed "s/ //g" "$FILENAME" | sed "s/\t//g" > "$OUTPUTFOLDER/$OUTPUTFILENAME"