#!/bin/bash

. ./common.sh
. ./netgen.sh


#Limpio el directorio
clean (){
echo "Creo directorio ${TEMP_DIR} vacio"
if [ ! -d ${TEMP_DIR} ]; then
    mkdir ${TEMP_DIR}
fi

# Clean temporary directory
rm ${TEMP_DIR}/*
}


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

gen_netfile () {

    # Filename for the netfile
    local FILESTEM=${TEMP_DIR}/${TEMP_STEM}
    # Random seed
    local SEED=$(gen_rand)


    echo "**** Generating netfile for seed=${SEED}"
    generate_netfile 2 2 ${TRAIN_SIZE} ${TRAIN_SIZE} ${TEST_SIZE} ${SEED} 0 ${BINS} ${FILESTEM}.nb


    echo "**** Finished running training "
 
    ${NB_PATH} ${FILESTEM} > ${FILESTEM}.output


}

export -f gen_netfile



#generete netfile
gen_netfile







