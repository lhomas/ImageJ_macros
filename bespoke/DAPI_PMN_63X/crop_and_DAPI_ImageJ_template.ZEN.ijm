// Open DAPI Channel Image
open("CURRENT/LOCATION/LOCATION_c1_BW.tif");

// Set scale
run("Set Scale...", "distance=183 known=10 unit=μm");

// Make Rectangular selection
makeRectangle(DIM1, DIM2, DIM3, DIM4);

// Make cropped duplicate of image
run("Duplicate...", "title=LOCATION_c1_MASK.tif");

// Perform Gaussian blur to normalise nuclear signal
run("Gaussian Blur...", "sigma=3");

// Autothresholding
setAutoThreshold("Huang dark no-reset");

// Create mask
run("Convert to Mask");

// Run watershed to separate adjacent nuclei
run("Watershed");

// Outline cells
run("Analyze Particles...", "size=1-Infinity summarize add");

// Select DAPI Channel Image
selectImage("LOCATION_c1_BW.tif");

// Make cropped duplicate of image
run("Duplicate...", "title=LOCATION_c1_CELL.tif");

// Delete current measurements from the results table
Table.deleteRows(0,Table.size);

// Specify measurements to include in outuput
run("Set Measurements...", "area mean standard modal min shape redirect=None decimal=3");

// Overlay nuclear oulines with green channel image.
run("From ROI Manager");

// Generate measurements
roiManager("Measure");

//Save a summary table
saveAs("Results", "CURRENT/LOCATION/LOCATION_c1_BW.summary(DAPI).CELL.csv");

// Save green image with nuclear overlay
saveAs("Tiff", "CURRENT/LOCATION/LOCATION_c1_BW.Overlay(DAPI).CELL.tif");

// Delete current measurements from the results table
Table.deleteRows(0,Table.size);

// Clear ROI manager
roiManager("Delete");

// Close all windows
run("Close All");
