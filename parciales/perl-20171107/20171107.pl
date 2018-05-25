#!/usr/bin/perl

sub isCorrectDay {
	
	if($_[0]<=0 || $_[0]>=365){
		return (0);
	} else{
		return (1);
	}

}

($beginDayParam,$endDayParam) = @ARGV;

if(isCorrectDay($beginDayParam) == 0)
{

	die("El primer parametro debe ser un dia de inicio entre 1 y 365");

} elsif(isCorrectDay($endDayParam) == 0){

	die("El segundo parametro debe ser un dia de fin entre 1 y 365");

} elsif($beginDayParam > $endDayParam){

	die("El dia de inicio debe menor o igual que el dia final");

} else{ # start program

	%consumoPrevisto = ();
	$salida="./salida/informe.txt";
	$entradaPinturas="./stock/pinturas.txt";
	$previsionDir="prevision";

	open(STOCK_OUT,">$salida")  || die "Problema al abrir /salida/informe.txt\n";
	open(PINTURAS_IN,"<$entradaPinturas") || die "Problema al abrir /stock/pinturas.txt\n";

	while($linePaint=<PINTURAS_IN>){ #por cada linea de stock
		chomp($linePaint);
		@paint=split(",",$linePaint);
		$codeColor=$paint[0];
		$consumoPrevisto{$codeColor} = 0;

		opendir(CONSUMO_DIR,"$previsionDir") || die "Problema al abrir el directorio /prevision\n";
		while($filename=readdir(CONSUMO_DIR)){ # por cada directorio de consumos
			if(-r "$previsionDir/$filename"){
				@fileNameSplitted=split("-",$filename);
				$previsionDay=$fileNameSplitted[1];

				if($previsionDay >= $beginDayParam && $previsionDay <= $endDayParam){

					open(CONSUMO_IN,"<$previsionDir/$filename") || next;

					while($lineConsumo=<CONSUMO_IN>){
						@consumoSplitted=split(";",$lineConsumo);
						if(("$consumoSplitted[0]" eq "$codeColor") &&  exists($consumoPrevisto{"$codeColor"})){
							$consumoPrevisto{$codeColor} = $consumoPrevisto{$codeColor}+$consumoSplitted[1];
						}
					}

					close(CONSUMO_IN);
				}				
				

			} else{
				print "No tiene permisos de lectura para $filename\n";
			}
		}
		closedir(CONSUMO_DIR);

		print STOCK_OUT "Color:$codeColor;Consumo previsto:$consumoPrevisto{$codeColor}\n";
		print "$linePaint,$consumoPrevisto{$codeColor}\n";

	}
	
	close(PINTURAS_IN);
	close(STOCK_OUT);

}