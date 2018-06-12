#!/bin/bash

# los parametros corresponden a:
# N_IN:        CANTIDAD DE ENTRADAS
# N_Class:     CANTIDAD DE CLASES
# PTOT:   cantidad TOTAL de patrones en el archivo .data
# PR:     cantidad de patrones de ENTRENAMIENTO
# PTEST:  cantidad de patrones de test (archivo .test)
# SEED:   semilla para el rand()
# CONTROL:verbosity

# Comentarios:
# cantidad de patrones de validacion: PTOT - PR
# SEED: -1: No mezclar los patrones: usar los primeros PR para entrenar y
#           el resto para validar.
#        0: Seleccionar semilla con el reloj, y mezclar los patrones.
#       >0: Usa el numero como semilla, y mezcla los patrones.
# verbosity: 0:resumen, 1:0 + pesos, 2:1 + datos


generate_netfile() {
#asserts 8 parameters
if [ $# -le 7 ]; then
    echo "Not enough parameters to create netfile."
    exit
fi


    local N_IN=$1
    local N_Class=$2
    local PTOT=$3
    local PR=$4
    local PTEST=$5
    local SEED=$6
    local CONTROL=$7
    local NAMEFILE=$8

    ##Borro archivo anterior si existe
    rm -f ${NAMEFILE}
    echo "Creating netfile=${NAMEFILE}"
    for i in "$@"
        do
            echo ${i} >> $NAMEFILE
    done
    #Saca el nombre del archivo del namefile
    tail -n 1 "${NAMEFILE}" | wc -c | xargs -I {} truncate "${NAMEFILE}" -s -{}
}
export -f generate_netfile

# Generate a 4-byte unsigned random number greater than 0
gen_rand ()
{
    od -vAn -N4 -tu4 < /dev/urandom | awk '{print 1 + $1}'
}
export -f gen_rand





