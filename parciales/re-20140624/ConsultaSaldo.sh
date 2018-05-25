#/bin/bash

#entrada estandar numero de documento
DNI=`grep "^[0-9]*$"`
grep "^.*;.*;$DNI;.*;ACTIVO;[0-9]\{3\}\/[0-9]\{8\};\$.*,[0-9][0-9]$" Cuentas.Master | sed "s&^\(.*\);.*;$DNI;.*;ACTIVO;\([0-9]\{3\}\)\/\([0-9]\{8\}\);\(\$.*,[0-9][0-9]\)$&\1 \2 \3 \4&g"