#!/bin/bash

#Cargo las variables en comun con el procesador
. ./common.sh

rm -f ${TEMP_DIR}/${TEMP_STEM}.errors

echo "Train,Validation,Test" > ${TEMP_DIR}/${TEMP_STEM}.errors

STEM_PATH=${TEMP_DIR}/${TEMP_STEM}

echo "Cleaning .tre .vae .tee"

rm -f ${STEM_PATH}.tre
rm -f ${STEM_PATH}.vae
rm -f ${STEM_PATH}.tee

    echo "*** Training ${STEM_PATH}..."


    grep "Entrenamiento" ${STEM_PATH}.output | awk -F ":" '{gsub(/(%| )/,""); print $2}' >> ${STEM_PATH}.tre
    grep "Validacion" ${STEM_PATH}.output | awk -F ":" '{gsub(/(%| )/,""); print $2}' >> ${STEM_PATH}.vae
    grep "Test" ${STEM_PATH}.output | awk -F ":" '{gsub(/(%| )/,""); print $2}' >> ${STEM_PATH}.tee



echo "Gathering data for ${STEM_PATH}..."

TRAIN_ERR=$(cat ${STEM_PATH}.tre | awk '{acum+=$1; ++n} END {print acum/n}')
VALIDATION_ERR=$(cat ${STEM_PATH}.vae | awk '{acum+=$1; ++n} END {print acum/n}')
TEST_ERR=$(cat ${STEM_PATH}.tee | awk '{acum+=$1; ++n} END {print acum/n}')

echo "${TRAIN_ERR},${VALIDATION_ERR},${TEST_ERR}" >> ${TEMP_DIR}/${TEMP_STEM}.errors


