#!/bin/bash

# 5 EMAIL
# Realizar un shell script que reciba por parámetro un email e indique si es válido o no.

if [ -z $1 ]
then
	echo "invalid"
else
	
	EMAIL=`echo $1 | grep "^[a-zA-Z0-9_.+\-]*@[a-zA-Z0-9\-]*\.[a-zA-Z0-9\-\.]*$" `

	RESULT="NO VALID $EMAIL"

	RESULT=`echo $RESULT | sed "s/NO VALID [a-zA-Z0-9_.+\-]*@[a-zA-Z0-9\-]*\.[a-zA-Z0-9\-\.]*$/VALID/" `
	echo $RESULT

fi