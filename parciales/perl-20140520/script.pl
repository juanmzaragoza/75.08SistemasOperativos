#!/usr/bin/perl
die "Debe ingresar organismo, mes a procesar y path de archivo de sueldos historicos\n" if(@ARGV != 3);
($organismo, $mesProcesar, $path) = @ARGV;
die "No existe el archivo de historicos $path\n" if (!(-f $path));

%sueldos=();
%montoHistorico=();
while(<$organismo-*-$mesProcesar>){

	@fileName=split("-",$_);
	$departamento=$fileName[1];

	open(SUELDOSIN,"<$_") || die "No se pudo abrir el archivo $fileName\n";
	while($line=<SUELDOSIN>){
		@sueldo=split(";",$line);
		$sueldoBasico=$sueldo[1];
		$adicionales=$sueldo[2];
		$descuentos=$sueldo[3];

		$total=$sueldoBasico+$adicionales-$descuentos;
		if( exists($sueldos{$departamento}) ){
			$sueldos{$departamento} += $total;
		} else{
			$sueldos{$departamento} = $total;
		}
	}
	close(SUELDOSIN);

	open(HISTORICOS,"$path") || die "No se puede abrir el archivo de historicos $path\n";
	while($line=<HISTORICOS>){
		@historico=split(",","$line");
		if($historico[0] eq $departamento){
			$montoHistorico{$departamento}=$historico[1];
		}
	}
	close(HISTORICOS);

}

print "Desea mostrar la salida por pantalla? [Y/n]: ";
$input=<STDIN>;
chomp($input);
if($input eq "Y"){

	print "Listado de sueldos por departamento del organismo: $organismo\n\n";

	print "Departamento		Sueldo del Mes 		Monto Historico\n";
	foreach $departamento (keys(%sueldos)){
		print "$departamento 			$sueldos{$departamento} 			$montoHistorico{$departamento}\n";
	}

} else{

	open(OUTPUT,">repo.txt");
	print OUTPUT "Listado de sueldos por departamento del organismo: $organismo\n\n";

	print OUTPUT "Departamento		Sueldo del Mes 		Monto Historico\n";
	foreach $departamento (keys(%sueldos)){
		print OUTPUT "$departamento 				$sueldos{$departamento} 				$montoHistorico{$departamento}\n";
	}
	closedir(OUTPUT);

}