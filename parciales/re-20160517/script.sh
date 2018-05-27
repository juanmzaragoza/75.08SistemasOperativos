#!/bin/bash

session=$1

localidad=`echo "$session" | grep "^.*|.*|.*|.*$" | sed "s/^.*|.*|.*|\(.*\)$/\1/"`

lista=`grep "^.*;.*;.*;$localidad;A$" ListaDePrecios.dat | sed "s/^\(.*\);.*;.*;$localidad;A$/\1/" `

echo "Lista de precios: $lista"

sed "s/^\(.*\);.*;\(.*\);.*;.*$/\1 + \2/g" "$lista"
echo ""