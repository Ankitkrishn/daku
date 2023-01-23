  GNU nano 2.9.3                                                                                                       daku.sh                                                                                                                  

#!/bin/bash
figlet DAKUU
domain=$1

# Create directory with domain name
mkdir $domain

# Find subdomains using subfinder
subfinder -d $domain  -o "${domain}/${domain}_subfinder.txt" ;sleep 10

# Use all methods of Amass to find subdomains
amass enum -d $domain -brute -passive -o "${domain}/${domain}_amass.txt" ;sleep 10

#asset finder

assetfinder --subs-only  $domain  | tee "${domain}/${domain}_asset.txt"  ;sleep 10



# combile amass and subfinder  and assetfinder

cat  "${domain}/${domain}_subfinder.txt"  "${domain}/${domain}_asset.txt"   "${domain}/${domain}_amass.txt" |sort -u | tee   "${domain}/${domain}_unique.txt" ;sleep 10

# Filter for live subdomains using httpx
cat "${domain}/${domain}_unique.txt" | httpx -silent | tee "${domain}/${domain}_live_subdomains.txt"  ;sleep 10


# Find URLs using waybackurls and save output
cat "${domain}/${domain}_live_subdomains.txt" | waybackurls  | tee "${domain}/${domain}_waybackurls.txt"




