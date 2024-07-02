#!/bin/bash

# ${1} = folder with microscope output files
# ${2} = .csv file with files to be blinded (can use input to crop_image pipeline)

cp -r ${1} ${1}_blinded

CURRENT=$(PWD)

cd ${1}_blinded

COUNTER=0

echo "Blind Map" > blind_map.txt

awk -F "," '{print $1}' ${2} | sed '$d' | sort | uniq | shuf | while read r; do 
	COUNTER=$((COUNTER + 1))
	
	echo "${COUNTER}:	${r}" >> blind_map.txt
	
	cd ${CURRENT}/${1}_blinded/${r} 
	
	for f in *.tif; do 
		mv "${f}" "$(echo ${f} | sed s@${r}@${COUNTER}@g)"
	done
	
	cd ${CURRENT}/${1}_blinded
	
	mv ${r} ${COUNTER}
	
done
