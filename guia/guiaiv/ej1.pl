#!/usr/bin/perl

# 1. Escriba un programa en Perl que lea dos números de entrada standard, los multiplique e
# imprima el resultado.

print "Ingrese 2 números a multiplicar, uno seguido del otro: \n";

$first_number = <STDIN>;
chomp($first_number);

$second_number = <STDIN>;
chomp($second_number);

if( ($first_number ne "0") && ($first_number == 0) ){

	print "El primer valor ingresado no era un número\n";
	exit;

}

if( ($second_number ne "0") && ($second_number == 0) ){

	print "El segundo valor ingresado no era un número\n";
	exit;

}

$result = $first_number*$second_number;
print "El resultado del producto de los números ingresados es: $result\n";