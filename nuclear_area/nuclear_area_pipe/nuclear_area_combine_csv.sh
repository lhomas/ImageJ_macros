#!/bin/bash

usage()
{
echo "# This is a script designed to combine .csv output from the ImageJ Nuclear Area pipeline.
# The results will be labeled in such a way that a reading can be traced back to the cell and image that it was generated from.
#
# This script NEEDS to be run in the directory where the .csv files are stored for it to work.
#
# Usage: bash nuclear_area_combine_csv.sh -p output_prefix -v vector_name -l coverslip_information [-s 
_pattern_to_identify.csv]
#
# This script takes as input 3 REQUIRED options and 1 OPTIONAL options.
# Options
# -p    REQUIRED.       Prefix used for combined output file.
# -l    REQUIRED.       Test to go into the first column of the .csv output to identify coverslip cell were imaged from.
# -v	REQUIRED.	Vector cells were transfected with.
# -s    OPTIONAL.       Pattern to identify .csv files. This pattern goes after a * to identify specific .csv files you want to analyse within the current directory. (Default: .csv)
# -h | --help           Print this message.
#
"
}

# Set variables
while [ "$1" != "" ]; do
	case $1 in
		-p )	shift
				prefix=$1
				;;
		-l )	shift
				label=$1
				;;
		-v )	shift
			vector=$1
			;;
		-s )	shift
				pattern=$1
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
if [ -z "${prefix}" ]; then # If no prefix is provided do not proceed
	usage
	echo "## ERROR: You need to provide a prefix for the output files."
	exit 1
fi

if [ -z "${label}" ]; then # If not label for cells in csv output is provided, do not proceed
	usage
	echo "## ERROR: You need to provide a label to identify cells in the csv"
	exit 1
fi

if [ -z "${vector}" ]; then # If no vector name is provided do not proceed
	usage
	echo "## ERROR: You need to provide the vector the cells were transfected with"
	exit 1
fi

if [ -z "${pattern}" ]; then # If no pattern provided, .csv will be set as default
	pattern=".csv"
	echo "NOTE: Using .csv to identify files to combine"
fi

# Create file with header containing column labels
echo "Vector,Cell$(head -n 1 $(ls *${pattern} | ls $(head -n 1)))" | sed 's/ //g' > ${prefix}_nuclear_area_combined.txt

# Add data from specified .csv files to above created .csv
for i in $(seq $(ls *${pattern} | wc -l));
do
	awk -v vector=${vector} -v line=${i} -v title=${label} 'NR > 1 {print vector","title"_"line"_"$0}' *_${i}_*${pattern} >> ${prefix}_nuclear_area_combined.txt
done

mv ${prefix}_nuclear_area_combined.txt ${prefix}_nuclear_area_combined.csv
