#!/bin/bash

usage() {
echo "# Pipeline to generate macros for cell counting to generate transfection efficiencies with ImageJ
# This pipeline takes as input a template macro that can be used to do cell counts in ImageJ and substitutes in specified values to make it a working script.
# THESE ARGUMENTS ARE POSITIONAL. ALL ARGUMENTS ARE REQUIRED. Please provide them in the correct order.
# This script produces a single 'complete' macro that can be run in ImageJ to perform counts for each image taken from a given coverslip.
#
# Arg 1: /Path/to/input/files/ (This should be the path to the directory that contains all the export directory from AxioVision)
# Arg 2: Plasmid_used
# Arg 3: /Path/to/output_directory
# Arg 4: Macro template file
#
# Argument notes
#
# Thresholds: These values need to be determined for each round of cell counting as they will differ depending intensity of fluorscent signals
# Thresholds: To determine the appropriate threshold follows these steps: 
# 1. Open a representative image in ImageJ
# 2. Select Image -> Colour -> Split Channels, and select window with signal you are interested in 
# 3. Select Image -> Adjust -> Brightness/Contrast -> Set. Select 'Propagate to all other open images', and select '8-bit (0-255)' from the 'Unsigned 16-bit range'.
# 4. Select LUT from main toolbar and select Grays
# 5. Select Image -> Adjust -> Threshold. Set maximum to 255 and adjust minimum value until the red colour covers area you are wanting to count. It is good to make it slightly smaller than the full area to prevent large clusters of cells being counted as one large nucleus. 
#
# Macro template: For this pipeline to work, the following values need to be present in the template, and will be subbed out for arguments supplied to this pipeline.
# PATH1: Complete path to input .TIF file.
# FILE: Name of input .TIF file without path.
# DAPITHRESH: Determined minimum threshold for DAPI counting
# SECONDTHRESH: Determined minimum threshold for secondary signal.
# OUTPUT: Directory for output files.
# PREFIX: File name without path or .TIF extension.
"
}

# Set path of script used to generate macro files
MACROGEN=~/Immunofluorescence/Macros/nuclear_volume/NuclearVolumePipe/NuclearVolumeMacroGen.sh

# Make output directory 
mkdir -p ${3}

# Generate macro for each image taken from a given coverslip.
ls ${1}/*/*\).TIF | while read r; do \
bash ${MACROGEN} \
${r} \
${2} \
${3} \
${4} ; done 

# Go to output directory and combine all macros into a single file that can be run on ImageJ
cd ${3}/${2}

cat *.ijm > complete_macro_${2}.ijm