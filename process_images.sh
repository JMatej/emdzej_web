# Convert .jpg files to .webp if the .webp file does not already exist
for file in images/large/*.jpg; do
    webp_file="${file%.*}.webp"
    if [ ! -f "$webp_file" ]; then
        echo "Converting $file to $webp_file..."
        cwebp "$file" -q 40 -o "$webp_file"
    fi
done

# Resize images to 35%, overwriting if the small version already exists
for file in images/large/*.{jpg,webp}; do
    if [[ ! -f "images/small/$(basename "$file")" ]]; then
        echo "Converting $file to small version..."
        magick "$file" -resize 35% "images/small/$(basename "$file")"
    fi
done

