#!/usr/bin/perl

die "ERROR!! Debe ingresar la opcion -l o -c junto con un 'CONTADOR CERTIFICANTE'\n" if(@ARGV != 2);
$opt=$ARGV[0];
die "ERROR!! Las opciones -l o -c son obligatorias\n" if($opt ne "-l" && $opt ne "-c");
die "ERROR!! No se puede leer el archivo control-pagos-tab\n" if( !(-r "control-pagos.tab") );
$contadorCertificante=$ARGV[1];

open(CONTROLPAGO,"<control-pagos.tab");
while($line=<CONTROLPAGO>){
	$i=index($line,$contadorCertificante,0);
	if($i>=0){
		last;
	}
}
close(CONTROLPAGO);

die "ERROR!! No existe el contador certificante $contadorCertificante\n" if($i < 0);

if( $opt eq "-l" ){

	open(CONTROLPAGO,"<control-pagos.tab");
	while($line=<CONTROLPAGO>){
		$i=index($line,$contadorCertificante,0);
		if($i>=0){
			print "$line";
		}
	}
	close(CONTROLPAGO);

} else{ # -c

	%resultados = ();
	print "Indique donde quiere guardar la salida: ";
	$fileOutName=<STDIN>;
	chomp($fileOutName);

	if( !(-f $fileOutName)){
		open(FILEOUT,">$fileOutName") || die "ERROR!! No se puede crear $fileOutName\n";
	} else{
		open(FILEOUT,">>$fileOutName") || die "ERROR!! No se puede appendear $fileOutName\n";
	}

	while(<fp.[0-9][0-9][0-9][0-9]>){

		open(FILEFACTURA,"<$_");

		while($facturaLine=<FILEFACTURA>){
			$i=index($facturaLine,$contadorCertificante,0);
			if($i>0){
				@factura=split(";",$facturaLine);
				$cuit=$factura[1];
				$montoPagar=$factura[2];

				if(exists($resultados{$cuit})){
					$resultados{$cuit} += $montoPagar;
				} else{
					$resultados{$cuit} = $montoPagar;
				}
			}
		}

		close(FILEFACTURA);

	}

	open(CONTROLPAGO,"<control-pagos.tab");
	while($line=<CONTROLPAGO>){
		chomp($line);
		$i=index($line,$contadorCertificante,0);
		if($i>=0){
			@controlPago=split(";",$line);
			if(exists($resultados{$controlPago[1]}) && $resultados{$controlPago[1]} == $controlPago[2]){
				$resultado="CORRECTO";
			} else{
				$resultado="INCORRECTO";
			}
			print FILEOUT "$controlPago[0];$controlPago[1];$controlPago[2];$resultados{$controlPago[1]};$resultado\n";
		}
	}

	close(CONTROLPAGO);
	close(FILEOUT);

}