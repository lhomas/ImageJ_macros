//open image
open("LOCATION");

// Convert image to black and white (8-bit)
run("8-bit");

//Save file
saveAs("Tiff", "OUTPUT/PREFIX_BW.tif");

// Close all images
run("Close All");
