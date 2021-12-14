#!/bin/bash

ausgabe=$1
username=$2
password=$3

userAgent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.1 Safari/605.1.15"

# get CSRF-Token
csrfToken$(curl -L -c tmp_cookie_store \
-H "User-Agent: $userAgent" \
-H "Upgrade-Insecure-Requests: 1" \
https://epaper.rp-online.de \
| grep 'name="_csrfToken"' | head -n 1 | sed 's/.*value="\(.*\)".*/\1/')

# Login
curl -v -i -L \
-c tmp_cookie_store \
-b tmp_cookie_store \
-H "Referer: https://epaper.rp-online.de/" \
-H "Origin: https://epaper.rp-online.de" \
-H "Content-Type: application/x-www-form-urlencoded" \
-H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" \
-H "User-Agent: $userAgent" \
-H "Accept-Language: de-DE,de;q=0.9" \
--data-urlencode "_csrfToken=$csrfToken" \
--data-urlencode "username=$username" \
--data-urlencode "password=$password" \
https://epaper.rp-online.de/auth?redirectTo=/

# Issue ID
issueid=$(curl -v -i -L \
-c tmp_cookie_store \
-b tmp_cookie_store \
-H "Referer: https://epaper.rp-online.de/" \
-H "Origin: https://epaper.rp-online.de" \
-H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" \
-H "User-Agent: $userAgent" \
-H "Accept-Language: de-DE,de;q=0.9" \
https://epaper.rp-online.de/$ausgabe \
 | grep "Jetzt lesen" | cut -d '"' -f 2 | cut -d "/" -f3)

# PDF Download
curl -L \
-c tmp_cookie_store \
-b tmp_cookie_store \
-H "Referer: https://epaper.rp-online.de/" \
-H "Origin: https://epaper.rp-online.de" \
-H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" \
-H "User-Agent: $userAgent" \
-H "Accept-Language: de-DE,de;q=0.9" \
https://epaper.rp-online.de/download/$issueid -O -J

# Logout
curl -v -i -L \
-b tmp_cookie_store \
-H "Referer: https://epaper.rp-online.de/" \
-H "Origin: https://epaper.rp-online.de" \
-H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" \
-H "User-Agent: $userAgent" \
-H "Accept-Language: de-DE,de;q=0.9" \
https://epaper.rp-online.de/auth/abmelden

# Cleanup
rm tmp_cookie_store