#!/bin/bash

# USAGE: BW_save_macrogen.sh /path/to/file_list.txt /path/to/macrotemplate.ijm

# Create macro.ijm in current directory
touch save_BW_single_channel_IJ_macro.ijm

# Loop through all merged channel images in specified directory and add to macro file
cat ${1} | while read r; do
	LOCATION=${r}
	PICTURE=$(basename ${LOCATION})
	PREFIX=$(basename ${LOCATION} .tif)
	OUTPUT=$(dirname ${LOCATION})

	cat ${2} | \
	sed -e "s@LOCATION@${LOCATION}@g" \
	-e "s@PICTURE@${PICTURE}@g" \
	-e "s@OUTPUT@${OUTPUT}@g" \
	-e "s@PREFIX@${PREFIX}@g" \
	>> save_BW_single_channel_IJ_macro.ijm;
done

