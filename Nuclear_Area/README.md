# Calculating Nuclear Area with ImageJ

Pipeline and scripts to generate macros for calculating nuclear volume in ImageJ.

These scripts assume that DAPI is on the blue channel and the secondary signal from the trasnfected cells is green. If this isn't the case the macro template will need to be altered to contain the relevant colours for each channel.

# Pipeline 

This pipeline takes as input a template macro, and a list of images (full path + file name). It uses these to generate a macro to copmlete the nuclear volume analysis for each of the provided images. These macros are then concatinated into one large macro that can be run to streamline the analysis. 
