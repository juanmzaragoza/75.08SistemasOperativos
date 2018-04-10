#/bin/bash

#RESULTADO=`echo $1 | grep "[0-0][0-0]:[0-0][0-3]:[0-1][0-2]"`
#RESULTADO="$RESULTADO MAYOR"

#echo $RESULTADO | sed "s/[0-0][0-0]:[0-0][0-3]:[0-1][0-2]/NO/"

RESULTADO1=`echo $1 | grep "[0-9][0-9]:[0-9][0-9]:[0-9][0-9]"`
RESULTADO2=`echo $RESULTADO1 | grep "[0-9]*:[0-9][3-9]:[0-9]*"`
RESULTADO3=`echo $RESULTADO2 | grep "[0-9]*:[0-9]*:[1-9][2-9]"`

echo $RESULTADO3 | sed "s/[0-9][0-9]:[0-9][0-9]:[0-9][0-9]/NO/"
