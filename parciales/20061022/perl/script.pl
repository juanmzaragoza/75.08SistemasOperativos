#!/usr/bin/perl

@dias=("domingo","lunes","martes","miercoles","jueves","viernes","sabados");
%accesos = ();

# para todos los accesos.txt
while (<"*accesos.txt">) {
	
	if( -f "$_" & !-z "$_" ){
		open(FILEIN,"$_");
		while($line=<FILEIN>){
			@acceso=split(";","$line");
			if(exists($accesos{$acceso[0]})){
				$accesos{$acceso[0]} += $acceso[2];
			} else{
				$accesos{$acceso[0]} = $acceso[2];
			}
		}
		close(FILEIN);
	}

}

foreach $dia (@dias){
	if(exists($accesos{$dia})){
		if($accesos{$dia}>0){
			print "$dia $accesos{$dia}\n";
			next;
		}
	}
	print "$dia NO HUBO ACCESOS\n";
}