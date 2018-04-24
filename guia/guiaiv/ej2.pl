#!/usr/bin/perl

# 2. Escriba un programa en Perl que utiliza la sentencia while para imprimir los primeros 10
# números (1-10) en orden ascendente.


$i = 1;
while($i <= 10){
	print $i++ . "\n";
}