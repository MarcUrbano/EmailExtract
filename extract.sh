#!/bin/bash
URL='https://www.googleapis.com/customsearch/v1'
KEY=[KEY]
CX=[CX]
DORK='intext:@"yahoo|gmail|hotmail".com filetype:txt site:[TARGET]'
PAGECNT=$(curl -s $URL"?q="$DORK"&key="$KEY"&cx="$CX"&start=1" |  jq -r '.queries.nextPage[0].startIndex')

echo '$PAGECNT'

for i in $(seq 1 $PAGECNT)
do
    curl -s $URL'?q=intext:@"yahoo|gmail|hotmail".com filetype:txt site:[TARGET]&num=10&key=[KEY]&cx=[CX]&start='$i |  jq -r '.items[].link' | tee -a mail.txt
done

for links in `cat mail.txt`;do
  curl -s $links | grep -E -o '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}' | tee -a emails.txt 
done

