#!/usr/bin/perl

sub imprimirPantalla {
	foreach $articulo (keys(%acumulados)){
		print "$articulo:$descripcionMaestro{$articulo} - $acumulados{$articulo}\n";
	}
}

die "El programa debe ser invocado al menos con dos parametros parcial.pl mascara posicion_monto_compra <guardar_archivo>\n" if (@ARGV < 2);

$mascara=$ARGV[0];
$posicionMontoCompra=$ARGV[1];
$archivoSalida=$ARGV[2];

die "El segundo parametro debe ser >= 1\n" if ($posicionMontoCompra < 1);

open(MAE,"<MaeArt") || die "No se puede abrir el archivo de maestros\n";
$maestro = join("",<MAE>);
@lineasMaestro = split("\n",$maestro);
%descripcionMaestro = ();
foreach $line (@lineasMaestro){
	@lineMaster=split(":",$line);
	$descripcionMaestro{$lineMaster[0]} = $lineMaster[1];
}
close(MAE);

opendir(CURRENTDIR,".") || die "No se puede abrir el directorio corriente\n";
@currentDirFiles=readdir(CURRENTDIR);
closedir(CURRENTDIR);

%acumulados = ();

foreach $fileName (@currentDirFiles){
	if($fileName =~ /$mascara/){
		open(FILEIN,"<$fileName");
		while($line=<FILEIN>){

			@lineFile=split(",","$line");
			die "El segundo parametro debe ser menor a la cantidad de campos del archivo\n" if($posicionMontoCompra >= @lineFile+1);

			$montoCompra=$lineFile[$posicionMontoCompra];
			$articulo=$lineFile[$posicionMontoCompra+1];

			die "Articulo $articulo de $fileName invalido\n" if ( ! exists($descripcionMaestro{$articulo}) );

			$acumulados{$articulo} += $montoCompra;
		}
		close(FILEIN);
	}
}

if(!length($archivoSalida)){
	&imprimirPantalla;
} else{

	if( -f "$archivoSalida" ){
		open(OUTPUT,">>$archivoSalida");
	} else {
		open(OUTPUT,">$archivoSalida");
	}

	foreach $articulo (keys(%acumulados)){
		print OUTPUT "$articulo,$acumulados{$articulo}\n";
	}
	
	close(OUTPUT)
}
