#!/bin/bash

# Check for argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path>"
    exit 4
fi

# Destination directory
dest_dir="/run/user/1000/gvfs/mtp:host=Google_Pixel_6_Pro_1B011FDEE004MB/Interne gedeelde opslag/AAPS/exports"

# Create a zip filename based on the given path
zip_file_name=$(basename "$1")".zip"

# Check if the files exist in the given path
if [[ ! -f "$1/CustomWatchface.json" ]] || [[ ! -f "$1/CustomWatchface.png" ]]; then
    echo "Error: CustomWatchface.json or CustomWatchface.png not found in $1."
    exit 1
fi

# Compress the files into a zip file
# The -j option is used to junk (do not store) directory names, and the -9 option is used for best compression
zip -j -9 -r "$zip_file_name" "$1/CustomWatchface.json" "$1/CustomWatchface.png"

# Check if zip command was successful
if [[ $? -ne 0 ]]; then
    echo "Error: Failed to create zip"
    exit 2
fi

# Copy zip to the destination directory
cp -f "$zip_file_name" "$dest_dir"

# Check if copy command was successful
if [[ $? -ne 0 ]]; then
    echo "Error: Failed to copy zip to the destination."
    exit 3
fi

echo "Operation completed successfully!"
