// Macro template to add scale bar to .tif images exported from ZEN 3.9

// Open Image
open("LOCATION")

// Set image scale
run("Set Scale...", "distance=DISTANCE known=KNOWN unit=µm");

// Add scale bar
run("Scale Bar...", "width=WIDTH height=4 thickness=8 font=0 bold");

// Save image with scale bar
run("Save");

// Close image
run("Close All");