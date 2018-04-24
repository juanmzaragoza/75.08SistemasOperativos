#!/usr/bin/perl

# 4. Llenar dos vectores A y B de 45 elementos cada uno, sumar el elemento uno del vector A con el
# elemento uno del vector B y así sucesivamente hasta 45; almacenar el resultado en un vector C, e
# imprimir el vector resultante.

$tam=10;\

print "Ingrese $tam valores para llenar el vector A: \n";
for($i=0;$i<$tam;$i++){
	$value = <STDIN>;
	chomp($value);
	push(@A,$value);
}

print "Ingrese $tam valores para llenar el vector B: \n";
for($i=0;$i<$tam;$i++){
	$value = <STDIN>;
	chomp($value);
	push(@B,$value);
}

for($i=0;$i<$tam;$i++){
	push(@C,$A[$i]+$B[$i]);
}

print "El resultado de A+B es: ";
for($i=0;$i<$tam;$i++){
	print $C[$i]." ";
}
print "\n";