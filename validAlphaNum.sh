#!/bin/sh

#Programa que valida las entradas alfa numéricas

validAlphaNum(){
	
	#Esta función retornara 0 si todos los caracteres son alfa numericos
	#De lo contrario retornara 1

	#Remover todos los caracteres no alfa-numericos,
	#Se utiliza el comando sed "string editor" en la caneria junto con "echo", 
	#El parámetro más común es sustituto, o s.
	#Ese comando ordenará a Sed que escanee el texto entrante y reemplace cada instancia de la cadena
	#Para hacer que sed funcione en cada ocurrencia de la cadena de destino, utilice la bandera g al final del comando
	#Para más detalles sobre las clases de caracteres y expresiones de corchetes: 
	#https://www.gnu.org/software/grep/manual/html_node/Character-Classes-and-Bracket-Expressions.html

	filter="$(echo $1 | sed -e 's/[^[:alnum:]]//g')"
	
	if [ "$filter" != "$input" ] ; then
		return 1
	else
		return 0
	fi

}


#Lectura del string


echo -n  "Ingresa la cadena de texto:"
read input

if ! validAlphaNum "$input" ; then 
	echo "Tu entrada no es valida, solo se admiten caracteres alfa numericos." >&2
	exit 1
else
	echo "Entrada valida"
fi

exit 0

