#!/usr/bin/perl

# 3. Mostrar por salida standard los elementos de un array (usar sentencia for).

@arr = ("hola",1,2,"4.3",6.4);

for($i=0; $i<=$#arr; $i++){
	print "$arr[$i]\n";
}