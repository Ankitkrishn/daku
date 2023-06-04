#!/bin/bash

# Parse command-line arguments
while getopts "d:" opt; do
  case $opt in
    d)
      domain=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

# Construct the URL with the provided domain name
url="https://web.archive.org/cdx/search/cdx?url=*.$domain/*&output=text&fl=original&collapse=urlkey&filter=statuscode%3"

# Fetch the URL and extract the URLs
response=$(curl -s "$url")

# Remove empty lines from the response
response=$(echo "$response" | sed '/^\s*$/d')

# Prepend the domain name to each extracted URL
modified_urls=$(echo "$response" | sed "s|^|$domain|")

# Print the modified URLs without the domain name prefix
while read -r line; do
  echo "${line#$domain}"
done <<< "$modified_urls"
