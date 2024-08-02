#!/bin/bash

usage() 
{
echo "
# This script is used to merge .csv files output from the bespoke/DAPI_PMN_63X scripts.
#
# The script works as follows:
# 1. Moves to directory with ZEN output folders (provided as option to the script).
# 2. The output .csv file with the header added.
# NOTE: This header will match the .csv header from the bespoke/DAPI_PMN_63X scripts .
#		Two additional fields for transfection condition and image number.
# 		Transfection condition will be determined using predifned patterns in folder names and as such may need to be changed if vectors are changed.
# 3. The .csv files present in the directories from the provided list are looped through and the data is added to the previously .csv file.
# 
# USAGE: DAPI_PMN_63X_csv_merge.sh -z /path/to/zen_output_directory -0 output_prefix -i /path/to/image_list.txt
#
# This script has 3 REQUIRED options.
# Options
# -z	REQUIRED.	Path to directory that contains the ZEN output files with the .csv files you are combining.
# -o	REQUIRED.	Prefix used to name the combined output .csv file.
# -i	REQUIRED.	List of directories within the -z direcotry to search for .csv file.
# -h | --help		Print this message.
#
# Create: Thomas Litster 15/07/2024
#
"
}

# Set variables
while [ "$1" != "" ]; do
	case $1 in
		-z )	shift
				zen=$1
				;;
		-o )	shift
				prefix=$1
				;;
		-i )	shift
				inputs=$1
				;;
		-h | --help )	usage
						exit 0
						;;
		* )		usage
				exit 1
	esac
	shift
done


# Check options 
if [ -z "${zen}" ]; then # If directory with zen outputs is not provided, do not continue
	usage
	echo "## ERROR: you need to provide the directory containing ZEN outputs"
	exit 1
fi

if [ -z "${prefix}" ]; then # If not output prefix is provided, do not continue
	usage
	echo "## ERROR: You need to provide an prefix for the output .csv"
	exit 1
fi

if [ ! -f "${inputs}" ]; then # If input file is not provided or it does not exist, do not continue
	usage
	echo "## ERROR: No input file was provided, or the provided file does not exist, please provide a list of directories to search for .csv files"
	exit 1
fi

# Move to directory containing zen outputs
cd ${zen}

# Create output .csv file
echo "Vector,Cell$(head -n 1 $(ls */*.csv | head -n 1) | sed 's/ //g')" > ${prefix}_combined.csv 

# Loop through provided list to combine required .csv files

cat ${inputs} | while read r; do

	# Identify vector for transfection condition
	if [[ ${r} == *_Nesp3_* ]]; then
		vector=Nesprin3
	elif [[ ${r} == *_Fusion_* ]]; then
		vector=Fusion
	elif [[ ${r} == *_EV_* ]]; then
		vector=EmptyVector
	else
		echo "## ERROR: ${r} does not have a pattern that matches one of the provided vectors"
		exit 1
	fi
	
	# Set counter to number cells, to differentiate between cells taken from the same image
	counter=1
	
	ls ${r}/${r}*.csv | while read s; do
		awk -F "," \
		-v vector=${vector} \
		-v cell=$(echo ${r}.${counter}) \
		'NR > 1 {print vector","cell","$2","$3","$4","$5","$6","$7","$8","$9","$10","$11}' \
		${s} >>  ${prefix}_combined.csv 
		
		# Increment counter up
		counter=$((counter+1))
	done
done 
	

