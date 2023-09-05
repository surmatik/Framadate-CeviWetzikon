#!/bin/bash

markdown_dir="/var/www/framadate/docs"
template_file="/var/www/framadate/docs/template.php"
output_dir="/var/www/framadate/docs"

for markdown_file in "$markdown_dir"/*.md; do
    if [ -e "$markdown_file" ]; then
        filename=$(basename -- "$markdown_file")
        filename_noext="${filename%.*}"

        html_output="$output_dir/$filename_noext.php"

        pandoc "$markdown_file" -o "$html_output.tmp"
        sed -e '/<!-- INSERT_CONTENT_HERE -->/ {' -e 'r '"$html_output.tmp" -e 'd' -e '}' "$template_file" > "$html_output"
        
        rm "$html_output.tmp"
        rm "$markdown_file"
    fi
done

rm "$template_file"
rm "$0"