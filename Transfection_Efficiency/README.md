# ImageJ_cell_counting
Pipelines and scripts to generate macros to be run on ImageJ for counting cells and assessing transfection efficiency.

This pipeline is used to complete cell counting from .TIF files exported from AxioVision.

A few notes before using. This current script is assuming DAPI is blue, and the secondary signal you are interested in is green. The macro will need to be edited if your secondary signal is red.

An option for a DAPI threshold is part of this pipeline, however, the current iteration does not utilise this. It will still be included and need to be provided as input, however the value itself does not matter as the corresponding line in the macro template is commented out.

## Inital Pipeline
This pipline takes as input 7 positional arguments.
1. The path to the input files. When images are exported from axio vision the output directory contains a directory for each image exported, and within this directory there will be an image corresponding to each exported channel and a merged image. The input for this pipeline is the directory that contains all the sub-directories, not the directories that contain the images.
2. The amount of plasmid used in transfection. This is used in file naming. Additional information could be provided here.
3. Which plasmid was used in the tranfection. This is also used for file naming.
4. Minimum threshold for DAPI counting. This isn't used in currrent (14-11-2023) iteration of counting pipeline but is left in incase it needs to be used in future. This argument needs to be porvided regardless of whether it is used or not.
5. Minimum threshold for secondary signal counting.
NOTE: Instructions for determining threshold are available in usage of pipeline script.
6. Path to directory where you want the outputs of the pipeline to be produced.
7. Template macro for cell counting with ImageJ. This can be found on this github page but may need to be edited slighlty to match you use case.

This step of the pipeline produced individual macros for each image taken, and a "complete" macro that combines all macros generated. This complete macro can be run in ImageJ to streamline cell counting process.

## Post ImageJ Process
Once the cell counting has been completed the post_ImageJ_combine_csv.sh script can be run from within each output directory. This will combine the .csv files into one large .csv file that can be loaded into excel to calculate total number of cells counted and average transfection efficiency across all images. 

There are two positional argumets provided for this script:
1. The amount of plasmid used. Additional information can also be provided here if need be.
2. The plamid used for transfection. 
