#!/bin/bash

#Cargo las variables en comun con el procesador
. ./common.sh


for g in ${GENERATORS}
do
    rm -f ${TEMP_DIR}/${TEMP_STEM}_${g}.errors

    echo "d,Train,Validation,Test" > ${TEMP_DIR}/${TEMP_STEM}_${g}.errors

    for d in ${PARAM_d}
    do
        STEM_PATH=${TEMP_DIR}/${TEMP_STEM}_${g}_${d}

        echo "Cleaning .tre .vae .tee"

        rm -f ${STEM_PATH}.tre
        rm -f ${STEM_PATH}.vae
        rm -f ${STEM_PATH}.tee

        for i in $(seq ${GENERATIONS})
        do
            echo "*** Training ${STEM_PATH}_${i}..."


            grep "Entrenamiento" ${STEM_PATH}_${i}.output | awk -F ":" '{gsub(/(%| )/,""); print $2}' >> ${STEM_PATH}.tre
            grep "Validacion" ${STEM_PATH}_${i}.output | awk -F ":" '{gsub(/(%| )/,""); print $2}' >> ${STEM_PATH}.vae
            grep "Test" ${STEM_PATH}_${i}.output | awk -F ":" '{gsub(/(%| )/,""); print $2}' >> ${STEM_PATH}.tee

        done

        echo "Gathering data for ${STEM_PATH}..."

        TRAIN_ERR=$(cat ${STEM_PATH}.tre | awk '{acum+=$1; ++n} END {print acum/n}')
        VALIDATION_ERR=$(cat ${STEM_PATH}.vae | awk '{acum+=$1; ++n} END {print acum/n}')
        TEST_ERR=$(cat ${STEM_PATH}.tee | awk '{acum+=$1; ++n} END {print acum/n}')
        
        echo "${d},${TRAIN_ERR},${VALIDATION_ERR},${TEST_ERR}" >> ${TEMP_DIR}/${TEMP_STEM}_${g}.errors
    done
done


