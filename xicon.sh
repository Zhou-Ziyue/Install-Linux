#!/bin/bash

# Create symbolic links with xsi- prefix for files ending with -symbolic.svg
# Recursively searches through the target directory
# Usage: ./xsi.sh /path/to/directory

if [ $# -eq 0 ]; then
    echo "Usage: $0 /path/to/directory"
    exit 1
fi

TARGET_DIR="$1"

if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Directory '$TARGET_DIR' does not exist"
    exit 1
fi

# Find all files ending with -symbolic.svg recursively
while IFS= read -r file; do
    # Get the directory and filename
    dir=$(dirname "$file")
    filename=$(basename "$file")

    # Create symlink with xsi- prefix in the same directory
    linkname="xsi-$filename"
    link_path="$dir/$linkname"

    # Create the symlink
    ln -s "$filename" "$link_path"
    echo "Created link: $link_path -> $filename"
done < <(find "$TARGET_DIR" -type f -name "*-symbolic.svg")

# Update icon cache after all symbolic links are created
echo "Updating icon cache for $TARGET_DIR..."
gtk-update-icon-cache "$TARGET_DIR"

echo "Done!"
