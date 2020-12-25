#!/bin/sh 

#Se adapta un formato de fecha para la entrada de tres elementos en el siguiente orden "mes,dia y ano" en ingles
#El srcipt devolvera el mes abreviado con tres letras y la primera capitalizada, el dia y el ano en 4 digitos


MonthFormat(){

	#Ajustar la variable "month" a su valor en texto"

	case $1 in
		1) month="Jan" ;;
		2) month="Feb" ;;
		3) month="Mar" ;;
		4) month="Apr" ;;
		5) month="May" ;;
		6) month="Jun" ;;
		7) month="Jul" ;;
		8) month="Aug" ;;
		9) month="Sep" ;;
		10) month="Oct" ;;
		11) month="Nov" ;;
		12) month="Dec" ;;
		*) echo "$0: Numero de mes desconocido: $1" >&2; exit 1
	esac
	return 0
}

#Inicia el script principal, validacion del numero de parametros que necesita este script:

#Para compensar con los formatos de fecha:

if [ $# -eq 1 ] ; then
        set -- $(echo $1 | sed 's/[\/\-]/ /g')
fi


#Valida si son los 3 digitos correctos:

if [ $# -ne 3 ] ; then 
	echo "Uso del script $0 mes dia ano" >&2
	echo "Entradas validas: August 25 1998 o bien 4 3 2000" <&2
	exit 1
fi


#Valida que el usuario introduzca 4 digitos para el ano

if [ $3 -lt 99 ] ; then
	echo "$0: Introduzca 4 digitos para el ano." >&2; exit 1
fi

#Para validar si el mes se escribe con el nombre o con numero:
#Cabe mencionar que "-z" significa que el resultado de la sentencia este vacio o bien se mantenga en blanco.

if [ -z $(echo $1 | sed 's/[[:digit:]]//g') ] ; then
	MonthFormat $1
else
	#Manipulacion del string a traves del comando cut y -c, que indica las posiciones del string que se cortan.
	#El comando tr reemplaza caracteres en archivos de texto. Para ello lee la entrada estándar 
	#Y envía los resultados a la salida estándar.

	month="$(echo $1 | cut -c1 | tr '[:lower:]' '[:upper:]')"
	month="$month$(echo $1 | cut -c2-3 | tr '[:upper:]' '[:lower:]')"

	#Se puede concatenar strings siempre y cuando sean enunciados dentro de las comillas dobles
	#En el comando cut, se inidica que se cortaran el segundo y el tercer caracter del string y seran remplazados a minusculas
	#Con el primer elemento que sea mayuscula (c2) el sistema realiza ese cambio a partir del primer caracter que lo cumpla,
	#En este caso es (c2)

fi

echo $month $2 $3

exit 0
