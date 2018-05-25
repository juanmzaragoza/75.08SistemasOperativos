#/bin/bash

PAIS=$1
CONDICION=$2

# obtengo el id del equpo ingresado como parametro
PAISID=`grep "^[0-9][0-9]*,$PAIS,.*$" Country.List | sed "s/^\(.*\),$PAIS,.*$/\1/g"`
echo "El id de $PAIS es $PAISID"

CONDICION="LOCAL;VISITANTE"
RECONDICION=`echo "$CONDICION" | sed "s/$2;VISITANTE/$PAISID;.*/"`
RECONDICION=`echo "$RECONDICION" |sed "s/LOCAL;$2/.*;$PAISID/"`

RESULTADO="LOCAL;VISITANTE"
#RERESULTADO=`echo "$RESULTADO" | sed "s#$2;VISITANTE#\\ 2\\ 3 a \\ 4\\ 5#"`
#RERESULTADO=`echo "$RERESULTADO" | sed "s#LOCAL;$2#\\ 4\\ 5 a \\ 2\\ 3#"`
#RERESULTADO=`echo "$RERESULTADO" | sed "s# \([0-9]\)#\\\1#g"`
#echo "$RERESULTADO"

# GANADOS
# GRUPO A;09-07-2014;01;02;0100;0100;W02;MVP;NONE
grep "^.*;.*;$RECONDICION;.*;.*;W$PAISID;.*;.*$" "Match.Master" | sed "s/^.*;\(.*\);$RECONDICION;\([0-9]\)\([0-9]\)00;\([0-9]\)\([0-9]\)00;W$PAISID;.*;.*$/GANO el \1 \2\3 a \4\5/g"

# PERDIDOS
grep "^.*;.*;$RECONDICION;.*;.*;L$PAISID;.*;.*$" "Match.Master" | sed "s/^.*;\(.*\);$RECONDICION;\([0-9]\)\([0-9]\)00;\([0-9]\)\([0-9]\)00;L$PAISID;.*;.*$/PERDIO el \1 \4\5 a \2\3/g"

# EMPATADOS
grep "^.*;.*;$RECONDICION;.*;.*;T$PAISID;.*;.*$" "Match.Master" | sed "s/^.*;\(.*\);$RECONDICION;\([0-9]\)\([0-9]\)00;\([0-9]\)\([0-9]\)00;T$PAISID;.*;.*$/EMPATO el \1 \4\5 a \2\3/g"

# GANO POR PENALES
grep "^.*;.*;$RECONDICION;.*;.*;WP$PAISID;.*;.*$" "Match.Master" | sed "s/^.*;\(.*\);$RECONDICION;\([0-9]\)\([0-9]\)\([0-9]\)\([0-9]\);\([0-9]\)\([0-9]\)\([0-9]\)\([0-9]\);WP$PAISID;.*;.*$/GANO POR PENALES el \1 \2\3 a \6\7 (\4\5 a \8\9)/g"

# PERDIO POR PENALES
grep "^.*;.*;$RECONDICION;.*;.*;LP$PAISID;.*;.*$" "Match.Master" | sed "s/^.*;\(.*\);$RECONDICION;\([0-9]\)\([0-9]\)\([0-9]\)\([0-9]\);\([0-9]\)\([0-9]\)\([0-9]\)\([0-9]\);LP$PAISID;.*;.*$/PERDIO POR PENALES el \1 \2\3 a \6\7 (\8\9 a \4\5)/g"

# VISITANTE