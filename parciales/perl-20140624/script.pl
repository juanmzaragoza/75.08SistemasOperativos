#!/usr/bin/perl

($sec,$min,$day,$mmonth,$myear)=$locatime;
$year=$ARGV[0];
die "ERROR!! Debe ingresar un ano\n" if(!length($year));
die "ERROR!! Debe ingresar un ano mayor a 2000\n" if($year <= 2000);
die "ERROR!! Debe ingresar un ano menor a 2019\n" if($year >= 2019);

opendir(CURRENTDIR,".") || die "No se puede abrir el directorio corriente\n";
@files=readdir(CURRENTDIR);
close(CURRENTDIR);

%ventas = ();
while(1){
	print "Ingrese un mes [1-12]: ";
	$month=<STDIN>;
	chomp($month);

	$fileName="ventas.$month-$year";
	if( -f $fileName ){
		
		open(FILE,"<$fileName") || die("No se puede abrir $fileName\n");

		while($line=<FILE>){
			@venta=split(";",$line);
			$monto=$venta[1];
			@producto=split("-",$venta[0]);
			$modelo=$producto[1];

			if(exists($ventas{$modelo})){
				$ventas{$modelo} += $monto; 
			} else{
				$ventas{$modelo} = $monto;
			}

		}

		close(FILE);
		last;

	} else{

		print "No existe el archivo $fileName. El directorio contiene: \n";
		while (<ventas.*-$year>) {
			print "$_\n";
		}
		print "\n";

	}



}

print "Las ventas durante el mes $month del ano $year fueron de:\n";
foreach $modelo (sort(keys(%ventas))){
	print "$modelo \$$ventas{$modelo}\n";
}