#!/bin/bash

# USAGE: BW_save_macrogen.sh /path/to/directory_with_zen_outputs /path/to/macrotemplate

# Create macro.ijm in current directory
touch SAVE_BW_IJ_macro.ijm

# Loop through all merged channel images in specified directory and add to macro file
ls ${1}/*/*c1-3* | while read r; do
	LOCATION=${r}
	PICTURE=$(basename ${LOCATION})
	PREFIX=$(basename ${LOCATION} .tif)
	OUTPUT=$(dirname ${LOCATION})

	cat ${2} | \
	sed -e "s@LOCATION@${LOCATION}@g" \
	-e "s@PICTURE@${PICTURE}@g" \
	-e "s@OUTPUT@${OUTPUT}@g" \
	-e "s@PREFIX@${PREFIX}@g" \
	>> ./SAVE_BW_IJ_macro.ijm ;
done

