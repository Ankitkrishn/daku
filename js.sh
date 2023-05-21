  GNU nano 2.9.3                                                                                                                                                                                                                           js.sh                                                                                                                                                                                                                                      
#!/bin/bash

# Parse command line arguments
while getopts ":w:l:" opt; do
  case $opt in
    w)
      # Single website action
      website_name="$OPTARG"
      # Construct the URL to fetch the webpage URLs
      url="https://web.archive.org/cdx/search/cdx?url=*.${website_name}/*&output=text&fl=original&collapse=urlkey&filter=statuscode%3A200"

      # Retrieve the webpage URLs
      urls=$(curl -s "$url")

      # Filter the URLs ending with ".js"
      js_urls=$(echo "$urls" | grep -o 'https\?://[^[:space:]]*\.js$')

      # Print the website name
      echo "Website: $website_name"

      # Print the filtered URLs
      echo "$js_urls"
      echo
      ;;
    l)
      # List of websites action
      filename="$OPTARG"

      # Check if the file exists
      if [[ ! -f $filename ]]; then
          echo "File '$filename' not found."
          exit 1
      fi

      # Read each website name from the file
      websites=$(cat "$filename")

      # Iterate over each website name
      for website_name in $websites; do
          # Construct the URL to fetch the webpage URLs
          url="https://web.archive.org/cdx/search/cdx?url=*.${website_name}/*&output=text&fl=original&collapse=urlkey&filter=statuscode%3A200"

          # Retrieve the webpage URLs
          urls=$(curl -s "$url")

          # Filter the URLs ending with ".js"
          js_urls=$(echo "$urls" | grep -o 'https\?://[^[:space:]]*\.js$')

          # Print the website name
          echo "Website: $website_name"

          # Print the filtered URLs
          echo "$js_urls"
          echo
      done
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done







