#!/bin/bash

numeroFactura=$1

codigoBoletoBancario=`grep "^$numeroFactura,.*,.*,.*,.*$" FacturasElectronicas.dat | sed "s/^$numeroFactura,.*,\(.*\),.*,.*$/\1/"`
urlImageFactura=`grep "^$numeroFactura,.*,.*,.*,.*$" FacturasElectronicas.dat | sed "s/^$numeroFactura,.*,.*,\(.*\),.*$/\1/"`

grep "^$codigoBoletoBancario,.*,S,.*,.*$" BoletosBancarios.dat | sed "s=^$codigoBoletoBancario,\(.*\),S,.*,\(.*\)$=$urlImageFactura;\1;\2="