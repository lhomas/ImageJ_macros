#!/bin/bash

# Script for generating Macros for cell counting
# Speific experiment being used for is Nov2023_Cos7_Trans_Opt

#USAGE
# ${1} = Full path to file
# ${2} = Amount of plasmid
# $(3) = Transfected plasmid
# ${4} = Threshold determined for DAPI counting
# ${5} - Threshold determined for secondary signal counting
# ${6} = Path to output directory
# ${7} = Macro Template

PATH1=${1}
AMNT=${2}
PLAS=${3}
DAPI=${4}
SECONDARY=${5}
OUT=${6}
TEMPLATE=${7}

OUTPATH=$(echo ${6}"/"${2}"/"${3})
FILE=$(basename ${1})
PREFIX=$(basename ${1} .TIF)

mkdir -p ${6}/${2}/${3}

cat ${7} | \
sed -e "s@PATH1@${PATH1}@g" \
-e "s@FILE@${FILE}@g" \
-e "s@OUTPUT@${OUTPATH}@g" \
-e "s@PREFIX@${PREFIX}@g" \
-e "s@DAPI@${DAPI}@g" \
-e "s@SECONDARY@${SECONDARY}@g"\
> ${6}/${2}/${3}/${PREFIX}_IJ_macro.txt
