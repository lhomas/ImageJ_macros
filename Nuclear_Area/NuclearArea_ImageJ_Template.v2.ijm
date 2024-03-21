//
//path1 = Full path to .TIF to be analysed
//file = File name without path
//output = Path to output location
//prefix = File name for outputs, without path or .TIF extension
//

// Open file
open("PATH1");

// Set scale to millimeters
run("Set Scale...", "distance=1 known=0.17018 unit=mm");

// Split channles
run("Split Channels");

// Select DAPI Channel
selectWindow("FILE (blue)");

// Create DAPI channel Mask.
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

// Select Green Channel
selectWindow("FILE (green)");

// Overlay nuclear oulines with green channel image.
run("From ROI Manager");

// Delete current measurements from the results table
Table.deleteRows(0,Table.size);

// Specify measurements to include in outuput
run("Set Measurements...", "area mean standard min shape redirect=None decimal=3");

// Generate measurements
roiManager("Measure");

// Save green image with nuclear overlay
saveAs("Tiff", "OUTPUT/PREFIX_NuclearOverlay(green).tif");

//Save measurements made my imageJ as .csv file
saveAs("Results", "OUTPUT/PREFIX_NuclearOverlay_ROI_measures.csv");

// Clear ROI manager
roiManager("Delete");

// Close all windows
run("Close All");
