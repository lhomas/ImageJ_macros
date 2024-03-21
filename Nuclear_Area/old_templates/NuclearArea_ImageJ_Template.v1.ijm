//
//path1 = Full path to .TIF to be analysed
//file = File name without path
//output = Path to output location
//prefix = File name for outputs, without path or .TIF extension
//

// Open file
open("PATH");

// Split channles
run("Split Channels");

// Select DAPI Channel
selectWindow("FILE (blue)");

// Create DAPI channel Mask.
run("Enhance Contrast", "saturated=0.35");

run("Gaussian Blur...", "sigma=3");

setAutoThreshold("Huang dark no-reset");

run("Convert to Mask");

run("Watershed");

// Outline cells
run("Analyze Particles...", "  show=Outlines display summarize add");
selectImage("Drawing of FILE (blue)");

// Select Green Channel
selectWindow("FILE (green)");

// Overlay nuclear oulines with green channel image.
run("From ROI Manager");

Table.deleteRows(0,Table.size);

run("Set Measurements...", "area mean standard min shape redirect=None decimal=3");

roiManager("Measure");

saveAs("Tiff", "OUTPUT/PREFIX_NuclearOverlay(green).tif");

saveAs("Results", "OUTPUT/PREFIX_NuclearOverlay_ROI_measures.csv");

roiManager("Delete");

run("Close All");
