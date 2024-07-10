# Convert .jpg files to .webp if the .webp file does not already exist
#for file in images/minified/*.jpg; do
#   webp_file="${file%.*}.webp"
#    if [ ! -f "$webp_file" ]; then
#        echo "Converting $file to $webp_file..."
#        cwebp "$file" -q 40 -o "$webp_file"
#    fi
#done

# Resize images to specified widths, creating new versions if they don't exist
for file in images/original/**/*.jpg; do
    # Get the base name and the relative directory path
    base=$(basename "$file")
    filename="${base%.*}"
    extension="${base##*.}"
    relative_dir=$(dirname "${file#images/original/}")

    # Declare the array of widths
    declare -a widths=(600 1200 2000)

    # Create the corresponding directory structure in images/public if it doesn't exist
    mkdir -p "images/public/$relative_dir"
    
    # Copy the original file to the public directory
    cp "$file" "images/public/${relative_dir}/$base"

    # Loop through the widths and convert the image
    for width in "${widths[@]}"; do
        output="images/public/${relative_dir}/${filename}${width}w.${extension}"
        if [[ ! -f "$output" ]]; then
            echo "Converting $file to $width width version..."
            magick "$file" -resize "${width}x" "$output"
        fi
    done
done

