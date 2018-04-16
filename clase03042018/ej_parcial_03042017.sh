#/bin/bash

VAR=`grep [0-9],[0-9]`

ESTRELLAS=`echo "$VAR" | sed "s/\([0-9]\),\([0-9]\)/\1/" `
CANT_HUESPUEDES=`echo "$VAR" | sed "s/\([0-9]\),\([0-9]\)/\2/" `

grep -c "^..*;.*; *$ESTRELLAS *; *[0-9]* *; *$CANT_HUESPUEDES *; *29/03/2018 *; *DISP *" disponibilidad.dat
