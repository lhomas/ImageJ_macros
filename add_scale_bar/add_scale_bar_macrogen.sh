#!/bin/bash

# USAGE: add_scale_bar_marcogen.sh list_of_images.txt image_magnification scale_bar_size

usage() {
echo "# Pipeline to add scale bars to .tif images exported from ZEN
# This pipeline takes as input a list of images to which you want to add a scale bar, and the magnification of these images.
# PLEASE NOTE: This works for images taken from the neurogenetics microscope exported with ZEN, and uses distance values that might be specific to this system.
# If you are using this pipeline for images exported from a different system might need to have some of the distance values tweaked.
#
# This pipeline currently only has compatibility with 20x and 63x magnification images.
#
# USAGE:  add_scale_bar_marcogen.sh list_of_images.txt image_magnification scale_bar_size /path/to/template_macro.ijm
# All of the arguments are positional and required
#
# Arguments:
# 1: list_of_images.txt = A .txt file containing the complete path of all images to which you want to add scale bars.
# 2: image_magnification = 20 or 63 (10x magnification not currently supported)
#	 ## Depending on magnification chosen it will change the value of two variables: DISTANCE and KNOWN.
#	 ##	DISTANCE = number of pixels in the image that cover distance provided by KNOWN.
#	 ## KNOWN = Known distance in um covered by number of pixels specified in DISTANCE.
# 3: scale_bar_size = size of scale bar (in um).
# 4: template_macro = path to macro template for adding scale bars to images.
#
# Please note this file creates/overwrites a file called add_scale_bar_macro.ijm in the diretory where it is run. If there is already a file named to this in the current directory that you want to run please move it.
#
"
}

if [[ -z ${1} || ! -f ${1} ]]; then # If image .txt file doesn't exist then exit
	usage
	echo "## ERROR: The text file you have provided does not exist. Please double check provided path."
	exit 1
fi

if [[ ${2} == 63 ]]; then # If magnification is 63x set appropriate known distance and pixel values
	DISTANCE=183
	KNOWN=10
elif [[ ${2} == 20 ]]; then # If magnification is 20x set appropriate known distance and pixel values
	DISTANCE=290
	KNOWN=50
else # If none of the above values are selected, exit pipeline
	usage
	echo "## ERROR: You have provided a magnification that is not supported. Currently this pipeline only supports 20x and 63x images"
	exit 1
fi

if ! [[ ${3} != ^[0-9]+$ ]]; then # If option three is not a number for scale bar length, do not proceed.
	usage
	echo "## ERROR: The value provided as option 3 is not a number. Please provide a number ofr scale bar length."
	exit 1
fi

if [[ -z ${4} || ! -f ${4} ]]; then # If no macro template has been provided exit.
	usage
	echo "## ERROR: You need to provide a macro template file."
	exit 1
fi


# Create blank macro file
echo "// Macro to add scale bars to images" > add_scale_bar_macro.ijm

# Loop through all merged channel images in specified directory and add to macro file
cat ${1} | while read r; do
	LOCATION=${r}

	cat ${4} | \
	sed -e "s@LOCATION@${LOCATION}@g" \
	-e "s@DISTANCE@${DISTANCE}@g" \
	-e "s@KNOWN@${KNOWN}@g" \
	-e "s@WIDTH@${3}@g" \
	>> ./add_scale_bar_macro.ijm ;
done

