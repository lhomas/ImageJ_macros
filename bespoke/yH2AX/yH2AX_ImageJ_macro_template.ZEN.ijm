//
//folder = path to folder containing the exported images
//image = full path and basename of image being opened (excluding _cx.tif)
//prefix = name to be used for output files
//


// OPEN BLUE-DAPI IMAGE AND CREATE NUCLEAR OUTLINES
// Open blue channel image
open("IMAGE/PREFIX_c1.tif")

// Set Scale to µm
run("Set Scale...", "distance=183 known=10 unit=µm")

//Convert to black and white
run("8-bit");

// Enhance contrast
run("Enhance Contrast", "saturated=0.35");

// Perform Gaussian blur to normalise nuclear signal
run("Gaussian Blur...", "sigma=3");

// Autothresholding
setAutoThreshold("Huang dark no-reset");

// Create mask
run("Convert to Mask");

// Split connected nuclei with watershed
run("Watershed");

// Outline cells
run("Analyze Particles...", "size=10-Infinity circularity=0.8-1.00 exclude summarize add");


// OPEN GREEN AND OVERLAY NUCLEAR OUTLINES TO IDENTIFY TRANSFECTED CELLS
// Open blue channel image
open("IMAGE/PREFIX_c2.tif")

//Convert to black and white
run("8-bit");

// Overlay nuclear oulines with green channel image.
run("From ROI Manager");

// Delete current measurements from the results table
Table.deleteRows(0,Table.size);

// Specify measurements to include in outuput
run("Set Measurements...", "area mean standard min shape redirect=None decimal=3");

// Generate measurements
roiManager("Measure");

// Save green image with nuclear overlay
saveAs("Tiff", "IMAGE/PREFIX_NuclearOverlay(green).tif");

//Save measurements made my imageJ as .csv file
saveAs("Results", "IMAGE/PREFIX_NuclearOverlay_ROI_measures(green).csv");

// Delete current measurements from the results table
Table.deleteRows(0,Table.size);

// Clear ROI manager
// roiManager("Delete");


// OPEN RED-yH2AX AND OVERLAY NUCLEAR OUTLINES TO IDENTIFY TRANSFECTED CELLS
// Open blue channel image
open("IMAGE/PREFIX_c3.tif")

//Convert to black and white
run("8-bit");

// Overlay nuclear oulines with green channel image.
run("From ROI Manager");

// Delete current measurements from the results table
Table.deleteRows(0,Table.size);

// Specify measurements to include in outuput
run("Set Measurements...", "area mean standard min shape redirect=None decimal=3");

// Generate measurements
roiManager("Measure");

// Save green image with nuclear overlay
saveAs("Tiff", "IMAGE/PREFIX_NuclearOverlay(red).tif");

//Save measurements made my imageJ as .csv file
saveAs("Results", "IMAGE/PREFIX_NuclearOverlay_ROI_measures(red).csv");


//CLEAR OUT ALL DATA FROM THIS SET
// Delete current measurements from the results table
Table.deleteRows(0,Table.size);

// Clear ROI manager
roiManager("Delete");

// Close all windows
run("Close All");

