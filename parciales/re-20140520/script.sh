#!/bin/bash

CODIGO=$1

ESTADO=`echo $CODIGO | sed "s/^A$/SIN_REACTOR/"`
ESTADO=`echo $ESTADO | sed "s/^[B-Z]$/NORMAL/"`
ESTADO=`echo $ESTADO | sed "s/^AA$/NORMAL/"`
ESTADO=`echo $ESTADO | sed "s/^A[B-F]$/CALIENTE/"`
ESTADO=`echo $ESTADO | sed "s/^A[G-Z]$/SOBRECALENTADO/"`
ESTADO=`echo $ESTADO | sed "s/^A[A-Z]\{1,3\}$/SOBRECALENTADO/"`
ESTADO=`echo $ESTADO | sed "s/^[B-Z][A-Z]\{0,3\}$/SOBRECALENTADO/"`

echo "El estado es: $ESTADO"