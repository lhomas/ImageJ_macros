#/bin/bash

# This script is used to combined each of the individual cell count .csv outputs from ImageJ that can be loaded into excel.
# Run this script in the directory where ImageJ ouptut cell count .csv files.
# First argument should be plasmid amount.
# Second argument should be plasmid used in transfection.

head -n 1 $(ls *y.csv | head -n 1) > complete_${1}_${2}.csv
ls *y.csv | while read r; do tail -n 2 ${r} > complete_${1}_${2}.csv ; done
