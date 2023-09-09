#!/bin/bash

changes_file="/var/www/framadate/locale/framadate-dejson-changes.txt"
json_file="/var/www/framadate/locale/de.json"

while IFS= read -r line
do
  key=$(echo "$line" | awk -F ': ' '{print $1}' | sed 's/"//g')
  value=$(echo "$line" | awk -F ': ' '{print $2}' | sed 's/"//g')
  
  escaped_key=$(printf '%s\n' "$key" | sed 's/[[\.*^$/]/\\&/g')
  escaped_value=$(printf '%s\n' "$value" | sed 's/[[\.*^$/]/\\&/g')
  
  sed -i "s/\"$escaped_key\": \".*\",/\"$escaped_key\": \"$escaped_value\",/g" "$json_file"
done < "$changes_file"

rm "$changes_file"
rm "$0"