#!/bin/bash

# 4 FECHA
# Realizar un shell script que tome por entrada std una fecha (formato YYYY-MM-DD) e indique si
# es válida o no.

VAR=`grep "[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}"`

FILTER=`echo $VAR | grep "^[0-2][0-9]\{3\}-[0-1][0-9]-[0-3][0-9]$"`
RESULT="NO VALID $FILTER"

RESULT=`echo $RESULT | sed "s/^NO VALID [0-2][0-9]\{3\}-[0-1][0-9]-[0-3][0-9]$/VALID/"`

echo $RESULT
