#!/bin/bash

# Check for argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path>"
    exit 4
fi

# Destination directory
dest_dir="/run/user/1000/gvfs/mtp:host=motorola_motorola_edge_40_ZY22HW2Z83/Interne gedeelde opslag/AAPS/exports"

# Create a zip filename based on the given path
zip_file_name=$(basename "$1")".zip"

# Check if the directory exists
if [ ! -d "$1" ]; then
    echo "Error: Directory $1 does not exist."
    exit 1
fi

# Check if the JSON file exists
if [ ! -f "$1/CustomWatchface.json" ]; then
    echo "Warning: CustomWatchface.json not found in $1."
fi

# Compress all .png files and CustomWatchface.json into a zip file
# The -j option is used to junk (do not store) directory names, and the -9 option is used for best compression
zip -j -9 "$zip_file_name" "$1"/*.png "$1/CustomWatchface.json"

# Check if zip command was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to create zip"
    exit 2
fi

# Copy zip to the destination directory
cp -f "$zip_file_name" "$dest_dir"

# Check if copy command was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to copy zip to the destination."
    exit 3
fi

echo "Operation completed successfully!"
