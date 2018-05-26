#!/usr/bin/perl

$year=$ARGV[0];
die "ERROR!! El ano debe ser mayor o igual a 2004 o menor a 2018 \n" if($year >= 2018 || $year < 2004);

%historico = ();
$listaClientes=$ARGV[1];
@clientes= ();
$count=0;
foreach (@ARGV){
	if($count){
		push(@clientes,$_);
	}
	$count++;
}
print "@clientes\n";

while(<*-$year>){
	
	open(ARCHIVOPROCESAR,"<$_");
	
	while($line=<ARCHIVOPROCESAR>){

		@aProcesar=split(";",$line);
		$clienteId=$aProcesar[1];
		if(@clientes >= 1){
			# print "Proceso @clientes";
			$proceso=0;
			for($i=0;$i<@clientes;$i++){
				if($clientes[$i] eq $clienteId){
					$proceso=1;
				}
			}
			next if(!$proceso);
		}

		if($aProcesar[3] eq "FAC" || $aProcesar[3] eq "DEB"){
			$importe = $aProcesar[2];
		} elsif($aProcesar[3] eq "CRE"){
			$importe = -$aProcesar[2];
		} else{
			next;
		}
		print "$importe\n";

		if(!exists($historico{$clienteId})){
			$historico{$clienteId} = $importe;
		} else{
			$historico{$clienteId} += $importe;
		}

		
	}

}

print "@historico\n";

print "Donde quiere guardar la salida? ";
$dir=<STDIN>;
chomp($dir);

if(length($dir)){

	opendir(DIROUTPUT,"$dir") || die("ERROR!! No se puede abrir el directorio\n");
	closedir(DIROUTPUT);

} else{
	$dir=".";
}

open(FILEOUTPUT,">$dir/output.txt") || die("ERROR!! No se puede abrir el archivo de salida\n");

($sec, $min, $hour, $day, $month, $y) = localtime;
$y=$y+1900;

foreach $key (keys(%historico)){
	print FILEOUTPUT "$year;$key;$historico{$key};$y/$month/$dayH$hour:$min\n";
}

close(FILEOUTPUT);