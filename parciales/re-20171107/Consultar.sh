#!/bin/bash

grep -c "^.*;.*;$1;.*;.*;.*;.*$" CatalogoDePaquetes.dat | sed "s/^0$/No hay disponibilidad de paquete comercial para el ave/" | sed "s/^[0-9]*$/La disponibilidad de paquetes es:/"
grep "^.*;.*;$1;.*;.*;.*;.*$" CatalogoDePaquetes.dat | sed "s/^.*;\(.*\);.*;.*;.*;.*;.*$/\1/g" 