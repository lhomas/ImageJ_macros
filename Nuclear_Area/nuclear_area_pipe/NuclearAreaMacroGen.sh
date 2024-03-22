#USAGE
# ${1} = Full path to file
# $(2) = Transfected plasmid
# ${3} = Path to output directory
# ${4} = Macro Template

PATH1=${1}
PLAS=${2}
OUT=${3}
TEMPLATE=${4}

OUTPATH=$(echo ${3}"/"${2})
FILE=$(basename ${1})
PREFIX=$(basename ${1} .TIF)

mkdir -p ${OUTPATH}

cat ${4} | \
sed -e "s@PATH1@${PATH1}@g" \
-e "s@FILE@${FILE}@g" \
-e "s@OUTPUT@${OUTPATH}@g" \
-e "s@PREFIX@${PREFIX}@g" \
> ${OUTPATH}/${PREFIX}_IJ_macro.ijm
