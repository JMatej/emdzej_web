# Convert .jpg files to .webp if the .webp file does not already exist
for file in images/*.jpg; do
    webp_file="${file%.*}.webp"
    if [ ! -f "$webp_file" ]; then
        echo "Converting $file to $webp_file..."
        cwebp "$file" -q 50 -o "$webp_file"
    fi
done

# Resize images to 35%, creating a _small version if it doesn't already exist
for file in images/*.webp; do
    if [[ "$file" != *_small.webp && ! -f "${file%.*}_small.webp" ]]; then
        echo "Converting $file to small version..."
        magick "$file" -resize 35% "${file%.*}_small.webp"
    fi
done

