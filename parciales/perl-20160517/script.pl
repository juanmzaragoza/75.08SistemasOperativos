#!/usr/bin/perl

sub obtenerSubgenero {
	open(PELICULAS,"<./catalogos/peliculas.mae") || die "No se puede abrir el catalogo de peliculas\n";
	my ($line, $peli, $genero, $subgenero);
	my ($idPelicula) = @_;
	$subgenero=0;
	while($line=<PELICULAS>){
		@peli=split(":",$line);
		if("$peli[0]" eq "$idPelicula"){
			@genero=split("-",$peli[6]);
			$subgenero=$genero[1];
			last;
		}
	}
	close(PELICULAS);
	return ($subgenero)
}

%acumulado = ();
$sizeParams = @ARGV;
if($sizeParams > 2){
	die "Debe ingresar exatamente 2 parametros\n";
}

($idEspectador,$dir) = @ARGV;

$isEmpty=1;
while(<$dir/*.dat>){
	$isEmpty=0;
}

die "El directorio $dir no tiene archivos de espectadores" if $isEmpty;

while(<$dir/*.dat>){
	
	open(ESPECTADORESFILE,"<$_") || die "No se pudo abrir $_\n";

	while($lineEspectador=<ESPECTADORESFILE>){
		@espectador=split(":",$lineEspectador);
		if($espectador[1] eq $idEspectador){
			$idPelicula=$espectador[2];
			$subgenero=&obtenerSubgenero ($idPelicula);
			
			#no existe
			if(!$subgenero){
				$subgenero="indeterminado";
			}

			if(exists($acumulado{$subgenero})){
				$acumulado{$subgenero} += $espectador[5];
			} else{
				$acumulado{$subgenero} = $espectador[5];
			}
			
		}
	}

	close(ESPECTADORESFILE);

}

foreach $key (keys(%acumulado)){
	print "Clave=$key Cantidad de entradas=$acumulado{$key}\n";
}

#foreach (keys(%acumulado)){
#	print "Clave=$_ Cantidad de entradas=$acumulado{$_}\n";
#}

print "Desea guardar este resultado en un archivo: ";
$respuesta=<STDIN>;
chomp($respuesta);

if($respuesta eq "Y"){
	open(OUTPUTFILE,">output/$idEspectador.txt") || die "No se puede grabar el resultado en output/$idEspectador.txt";

	foreach $key (keys(%acumulado)){
		print OUTPUTFILE "Clave=$key Cantidad de entradas=$acumulado{$key}\n";
	}

	close(OUTPUTFILE);
}