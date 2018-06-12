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
    # Generator
    local GEN=$1
    # Number of dimensions
    local DIM=$2
    # Index of the current run
    local INDEX=$3
    # Filename for the netfile
    local FILESTEM=${TEMP_DIR}/${TEMP_STEM}_${GEN}_${DIM}_${INDEX}
    # Random seed
    local SEED=$(gen_rand)
    # Generator path


    echo "**** generating netfile for gen=${GEN}, dim=${DIM}, seed=${SEED}, round=${INDEX}"
    generate_netfile ${DIM} 2 ${TRAIN_SIZE} ${TRAIN_SIZE} ${TEST_SIZE} ${SEED} 0 ${FILESTEM}.nb

    #diagonal d n c namefile
    #parallel d n c namefile

    # symlink original train dataset FROM TP2
    echo "++++ Linking ${DATASET_PATH}/${FILESTEM}.data to ${FILESTEM}.data"
    ln -s ${DATASET_PATH}/${TEMP_STEM}_${GEN}_${DIM}_${INDEX}.data ${FILESTEM}.data
        

    # symlink test dataset from original linked test dataset
    echo "++++ Linking ${TEMP_DIR}/${TEMP_STEM}_${GEN}_${DIM}.test to ${FILESTEM}.test"
    ln -s ${TEMP_STEM}_${GEN}_${DIM}.test ${FILESTEM}.test


    echo "**** Finished running training with gen=${GEN}, dim=${DIM}, seed=${SEED}, round=${INDEX}"
 
    ${NB_PATH} ${FILESTEM} > ${FILESTEM}.output

}

export -f gen_netfile

clean


echo "Rounds: ${ROUNDS}"
echo "Generators: ${GENERATORS_NAMES}"
echo "Dimensions: ${GENERATORS_d}"
echo ""

for g in ${GENERATORS}
do
    for d in ${PARAM_d}
    do
        # symlink original test dataset FROM TP2
        echo "**** Linking ${TEMP_STEM}_${g}_${d}.test"
        ln -s ${DATASET_PATH}/${TEMP_STEM}_${g}_${d}.test ${TEMP_DIR}/${TEMP_STEM}_${g}_${d}.test
    done
done



# Run the training in parallel.
parallel gen_netfile ::: ${GENERATORS} ::: ${PARAM_d} ::: $(seq ${GENERATIONS})
#parallel gen_netfile ::: diagonal ::: 2 ::: $(seq ${GENERATIONS})
