#!/bin/bash

# USAGE: yH2AX_ImageJ_macrogen.sh /path/to/file_list.txt /path/to/macrotemplate.ijm

# Create macro.ijm in current directory
echo "//yH2AX_complete_IJ_macro" > yH2AX_IJ_macro.ijm

# Loop through all merged channel images in specified directory and add to macro file
cat ${1} | while read r; do
	IMAGE=${r}
	PREFIX=$(basename ${IMAGE})

	cat ${2} | \
	sed -e "s@IMAGE@${IMAGE}@g" \
	-e "s@PREFIX@${PREFIX}@g" \
	>> yH2AX_IJ_macro.ijm;
done
