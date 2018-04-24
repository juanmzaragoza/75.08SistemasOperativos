#!/usr/bin/perl

# 5. Cargar un vector con 10 elementos y calcular el promedio de los valores almacenados.
# Determinar además cuántos son mayores del promedio, imprimir el promedio, el número de datos
# mayores que el promedio.

$tam=10;

print "Ingrese $tam valores para calcular su promedio: \n";
for($i=0;$i<$tam;$i++){
	$value = <STDIN>;
	chomp($value);
	push(@arr,$value);
}

$result = 0;
for($i=0;$i<$tam;$i++){
	$result += $arr[$i];
}
$result /= @arr;

print "El promedio es: $result\n";

$gt = 0;
for($i=0;$i<$tam;$i++){
	if($arr[$i] > $result){
		$gt++;
	}
}

print "Hay $gt valores mayores que el promedio \n";