#!/bin/bash

usage() {
echo "
# Script to generate macro to crop images down to transfected nuclei and make measurements of nuclear size (and other things) for these nuclei with ImageJ
# This script takes as input a .csv file that has 6 columns:
# 1: Name of folder that contains images to be cropped
# 2: Number assigned to cell being analysed (e.g. 1 for first transfected cell in image, 2 for second transfected cell in image)
# 3: Dimension 1
# $; Dimension 2
# 5: Dimension 3
# 6: Dimension 4
# NOTE: This is the same .csv input from the crop_images script
# 
# To get the dimensions, open the image you are wanting to crop in ImageJ.
# Open the macro record function.
# Draw a square around the nuclei you want to select.
# Record the numbers that appear with the makeRectangle() function. In order these numbers are dimension 1 through 4.
#
# The arguments for this script are POSITIONAL, and so must be provided in the order specified below.
# 
# USAGE: bash /path/to/crop_images_macrogen.sh /path/to/location_file.csv /path/to/macro_template.ijm
# Please note that this script needs to be run in the directory that contains the ZEN output folders listed in the .csv file.
#
# This script will save as output a .csv file that contains the nuclear measurements along with a cropped image with a nuclear overlay. 
#
"
}

# Create complete macro .ijm file, or overwrite pre-existing macros in this directory
echo "// Crop and DAPI Measure Macro" > crop_DAPI_complete_IJ_macro.ijm

# Loop through provided .csv file to generate complete macro
cat ${1} | while read r; do
	LOCATION=$(echo ${r} | awk -F "," '{print $1}')
	CELL=$(echo ${r} | awk -F "," '{print $2}')
	DIM1=$(echo ${r} | awk -F "," '{print $3}')
	DIM2=$(echo ${r} | awk -F "," '{print $4}')
	DIM3=$(echo ${r} | awk -F "," '{print $5}')
	DIM4=$(echo ${r} | awk -F "," '{print $6}' | sed 's,\r,,g')
	CURRENT=$(PWD)

	cat ${2} | \
	sed -e "s@LOCATION@${LOCATION}@g" \
	-e "s@CURRENT@${CURRENT}@g" \
	-e "s@CELL@${CELL}@g" \
	-e "s@DIM1@${DIM1}@g" \
	-e "s@DIM2@${DIM2}@g" \
	-e "s@DIM3@${DIM3}@g" \
	-e "s@DIM4@${DIM4}@g" \
	>> crop_DAPI_complete_IJ_macro.ijm;
done