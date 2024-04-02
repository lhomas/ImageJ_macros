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

# Pipeline Versions

In early 2024 the lab updated the the camera and software used to take images from axio vision to ZEN Zeiss software suite. This change has lead to some minor alterations in the images export. As such, two different version of the pipeline area needed to allow for these differences. Currenlty the major differences are as follows:
1. Nuclear Area Pipe Script: The pattern used to identify the merged channel images to be input into the macro gen pipeline.
2. MacroTemplate: The value used to set the scale of the image within the ImageJ macro was changed as the pixels in the images are a different size in images taken with ZEN compared to AxioVision.

Any additional changes will be included above.

The macrogen script and merge csv results scripts are unchanged. These changes were introduced at v2 of the nuclear area macro. When analysing images produced with ZEN Zeiss Software, use versions of scripts and macros with .ZEN. in the name.
