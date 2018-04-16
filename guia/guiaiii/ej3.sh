#!/bin/bash

# 3 IP
# Realizar un shell script que reciba por parámetro una ip (EJ: 192.168.1.1) e indique si es válida o
# no.

if [ "$#" -lt 1 ];
then
	echo "ERROR: use mode: $ $0 192.168.1.1"
else
	IP=$1
	NOVALID='NO VALID'

	FILTER=`echo "$IP" | grep "^[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}$"`
	FILTER="$NOVALID $FILTER"

	RESULT=`echo $FILTER | sed "s/$NOVALID [0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}/VALID/"`

	echo $RESULT

fi