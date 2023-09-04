#!/bin/bash

changes_file="/var/www/framadate/locale/framadate-dejson-changes.txt"
json_file="/var/www/framadate/locale/de.json"

while IFS= read -r line
do
  key=$(echo "$line" | awk -F ': ' '{print $1}' | sed 's/"//g')
  value=$(echo "$line" | awk -F ': ' '{print $2}' | sed 's/"//g')
  
  sed -i "s/\"$key\": \".*\",/\"$key\": \"$value\",/g" "$json_file"
done < "$changes_file"