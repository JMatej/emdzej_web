# Convert .jpg files to .webp if the .webp file does not already exist
#for file in images/minified/*.jpg; do
#   webp_file="${file%.*}.webp"
#    if [ ! -f "$webp_file" ]; then
#        echo "Converting $file to $webp_file..."
#        cwebp "$file" -q 40 -o "$webp_file"
#    fi
#done

# Resize images to specified widths, creating new versions if they don't exist
for file in images/minified/*.{jpg,webp}; do
    base=$(basename "$file")
    filename="${base%.*}"
    extension="${base##*.}"

    declare -a widths=(300 600 820 1160 1420 1640)

    for width in "${widths[@]}"; do
        output="images/public/${filename}${width}w.${extension}"
        if [[ ! -f "$output" ]]; then
            echo "Converting $file to $width width version..."
            magick "$file" -resize "${width}x" "$output"
        fi
    done
done

