# Calculating Nuclear Area with ImageJ

Pipeline and scripts to generate macros for calculating nuclear volume in ImageJ.

These scripts assume that DAPI is on the blue channel and the secondary signal from the trasnfected cells is green. If this isn't the case the macro template will need to be altered to contain the relevant colours for each channel.

# Pipeline 

This pipeline takes as input a template macro, and a list of images (full path + file name). It uses these to generate a macro to copmlete the nuclear volume analysis for each of the provided images. These macros are then concatinated into one large macro that can be run to streamline the analysis. 

The macros produced are in the ImageJ Macro Language (.IJM files). These macros work in the following way:

1. Split the merged channel images into blue, green, and red channels.
2. Select the blue channel and create a mask (increase contrast -> Guassian Blur -> Huang dark auto-threshold -> convert to mask -> watershed to split clumped cells).
3. Analyse the mask to identify nuclear outlines.
4. Overlay these outlines onto the green fluorescence image.
5. Calculate relevant statistics with ROI manager.
6. Save statistics and green fluorsecnece with nuclear outline overlay (.TIF).

Depening on the instensity of the signal you are imaging, you may need to change the thresholding that is completed to one of the other auto options or with user defined seetings. 
