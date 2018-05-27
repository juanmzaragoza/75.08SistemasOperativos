#!/usr/bin/perl

# genero consumos previstos
# for($i=1;$i<=52;$i++){
# 	$name=sprintf("consumo_previsto/resmas_%02d", $i);
# 	open(OPENDIR,">$name");
# 	print OPENDIR "biblioteca;A4-82gr;4\n";
# 	print OPENDIR "despacho;A4-70gr;4\n";
# 	print OPENDIR "despacho;carta-82gr;4\n";
# 	close(OPENDIR);
# }

$CONSUMOPREVISTODIR="consumo_previsto";
$STOCKDIR="stock";

die "No existe el archivo $STOCKDIR/resmas_en_stock\n" if (!( -f "$STOCKDIR/resmas_en_stock" ));
die "Debe ingresar exactamente dos parametros \n" if ( @ARGV != 2);

$semanaInicio=$ARGV[0];
$semanaFin=$ARGV[1];
die "El parametro 1 debe ser un valor entre 1 y 52\n" if ( $semanaInicio > 52 | $semanaInicio < 1);
die "El parametro 2 debe ser un valor entre 1 y 52\n" if ( $semanaFin > 52 | $semanaFin < 1);
die "El segundo parametro debe ser mayor o igual que el primero\n" if ( $semanaFin < $semanaInicio);

while(1){
	print "Ingrese un tamano de papel [Por ej.: A4]: ";
	$tamanoPapel=<STDIN>;
	chomp($tamanoPapel);

	open(RESMASENSTOCK,"<$STOCKDIR/resmas_en_stock") || die "No se pudo abrir $STOCKDIR/resmas_en_stock\n";
	while($linea=<RESMASENSTOCK>){
		@lineaResma=split(";",$linea);
		@papelInfo=split("-",$lineaResma[0]);
		if($papelInfo[0] eq "$tamanoPapel"){
			$STOCKPAPEL += $lineaResma[1];
		}
	}

	if(defined($STOCKPAPEL)){
		print "El stock de $tamanoPapel es $STOCKPAPEL\n";
		last;
	}
	print "No existe el tamano $tamanoPapel\n\n";

}

opendir(CONSUMOPREVISTOIN,"$CONSUMOPREVISTODIR") || die("No se puede abrir el directorio $CONSUMOPREVISTODIR\n");
%stockOficina = ();
while($file=readdir(CONSUMOPREVISTOIN)){
	@fileName=split("_",$file);
	if($fileName[1]>=$semanaInicio & $fileName[1]<=$semanaFin){
		open(RESMASIN,"<$CONSUMOPREVISTODIR/$file") || die("No se puede abrir el archivo $CONSUMOPREVISTODIR/$file\n");
		while($line=<RESMASIN>){
			@resma=split(";",$line);
			if($resma[1] =~ /$tamanoPapel-.*/ ){
				if(exists($stockOficina{$resma[0]})){
					$stockOficina{$resma[0]} += $resma[2];
				} else{
					$stockOficina{$resma[0]} = $resma[2];
				}
			}
		}
		close(RESMASIN);
	}
}
closedir(CONSUMOPREVISTOIN);

open(OUTPUT,">salida")  || die("No se pudo grabar la salida\n");
foreach $despacho (keys(%stockOficina)){
	print OUTPUT "$tamanoPapel;semana $semanaInicio a $semanaFin;$despacho;$stockOficina{$despacho}\n"
}
close(OUTPUT);

