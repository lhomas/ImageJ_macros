//open image
open("LOCATION");

//Split into black and white channel images
run("Split Channels");

// Select and save the green channel black and white image
selectImage("PICTURE (green)");

saveAs("Tiff", "OUTPUT/PREFIX_BW(green).tif");

// Select and save the red channel black and white image
selectImage("PICTURE (red)");

saveAs("Tiff", "OUTPUT/PREFIX_BW(red).tif");

// Select and save the blue channel image
selectImage("PICTURE (blue)");

saveAs("Tiff", "OUTPUT/PREFIX_BW(blue).tif");

// Close all images
run("Close All");
