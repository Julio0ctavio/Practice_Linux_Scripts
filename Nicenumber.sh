#!/bin/sh

#Darle formato a un número cualquiera:

nicenumber(){

	#Un numero puede tener decimales siempre y cuando lo sea
	#para ello se utilizará una bandera
	#"-d" que indicara de que lado se evalua el numero:

	entero=$(echo $1 | cut -d. -f1) #izquierda del decimal
	decimal=$(echo $1 | cut -d. -f2) #derecha del decimal
	
	if [ $decimal != $1 ] ; then
	       result="${DD:="."}$decimal"
        fi	       

	thousands=$entero

	while [ $thousands -gt 999 ] ; do

		remainder=$((thousands % 1000))  #se obtiene al menos 3 dígitos



		while [ ${#remainder} -lt 3 ] ; do

			remainder="0$remainder"

		done	

		thousands=$(($thousands / 1000))
		result="${TD:=","}${remainder}${result}"

	done

	nicenum="${thousands}${result}"

	if [ ! -z $2 ] ; then
		echo $nicenum
	fi

}


DD="."
TD=","

while getopts "d:t:" opt; do

	case $opt in
		d) DD="$OPTARG"   ;;
		T) TD="$OPTARG"   ;;
	esac
done
shift $(($OPTIND - 1))

if [ $# -eq 0 ] ; then

	echo "Uso: $(basename $0) [-d c] [-t c] numeric value"
	echo " -d se refiere al decimal (.)"
	echo " -t se refiere al separar milésimas (,)"

	exit 1
fi

nicenumber $1 1 

exit 0
