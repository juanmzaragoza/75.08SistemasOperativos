#/bin/bash

re='^[0-9]+$'

if [ $# -lt 2 ] # wait two params always
then
	echo "Number of params incorrect. User mode:
  > $0 -c 25
  > $0 -f 25"
elif ! [[ "$2" =~ ^[0-9]+$ ]] # second param is not a number
then
	echo "The second param is not a number. User mode:
  > $0 -c 25
  > $0 -f 25"
elif [ $1 == '-c' ] # convert to f
then
	FRACTION=`echo "scale=2;9/5" | bc`
	F=`echo "($FRACTION * $2) + 32" | bc`
	echo "$2 *C => $F *F"
elif [ $1 == '-f' ] # convert to c
then
	FRACTION=`echo "scale=2;5/9" | bc`
	F=`echo "($FRACTION * ($2-32))" | bc`
	echo "$2 *F => $F *C"
else # exit
	echo "Use mode:
  > $0 -c 25
  > $0 -f 25"
fi
	
