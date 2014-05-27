#!/bin/bash

# Ian Dennis Miller
# iandennismiller@gmail.com
# citiq.sh creates a file called [query].csv containing data series

# usage: citiq.sh [ezproxy-cookie] [query]
#
# example: citiq.sh 0a1b2c3d4e5f EXRCAN
#
# Determine the ezproxy cookie by looking at the request headers of an authenticated browser session.
# Finding the cookie is beyond the scope of this script.

export COOKIE="ezproxy=$1"

# what symbol series do you want?
export QUERY=$2

# construct a query
export CITIBASE='http://dc.chass.utoronto.ca.myaccess.library.utoronto.ca/cgi-bin/citibase'
export CURL_URL="${CITIBASE}/getdataQ?s=${QUERY}&b=&e=&f=Spreadsheet"
export CURL_ACCEPT='text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8'
export CURL_UA='Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.114 Safari/537.36'

# request the file and store as ${QUERY}.csv
curl $CURL_URL -H 'DNT: 1' -H 'Accept-Encoding: gzip,deflate,sdch' -H 'Accept-Language: en-US,en;q=0.8' \
  -H "User-Agent: ${CURL_UA}" -H "Accept: ${CURL_ACCEPT}" -H "Referer: ${CITIBASE}/getcitiQ?${QUERY}" \
  -H "Cookie: ${COOKIE}" -H 'Connection: keep-alive' -H 'Cache-Control: max-age=0' \
  --compressed -o ${QUERY}.csv

# trim HTML at beginning and end to create parseable CSV
sed -i.bak -e '1,4d' ${QUERY}.csv
sed -i.bak -e :a -e '$d;N;2,4ba' -e 'P;D' ${QUERY}.csv
