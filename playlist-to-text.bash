#Created by: Nicholas Marthinuss
#1/13/19
#This program creates a file with the title of videos in a youtube playlist on separate lines
#The program relies on the link being in the format of youtube.com/playlist?list=id

#also sometimes it doesn’t work and I haven’t figured out why yet soooooo
#just keep running it and eventually it should work hopefully
#will update more later

#!/bin/bash

clear

echo "URL must be in format of youtube.com/playlist?list=id"
echo "Enter playlist URL:"
read URL

id=${URL:55:-1}
file="$id.tmp"
wget -O - $URL > $file

clear

#if [ "$?" = "0" ]
#then
#       echo An error occurred
#       rm "$file"
#       exit
#fi

title=$(cat $file | grep \<title\>)
title=${title:13:-18}

outfile="$title.txt"

touch "$outfile"
vidCount=$(cat $file | grep -c "pl-video yt-uix-tile")

echo "$vidCount videos found"
printf "$title\r\n" >> "$outfile"
#how to bold/underline?
#channel
#URL is already there
for i in $(seq 1 $vidCount)
do
        echo $i
        line=$(awk -v i=$i '/data-title/{j++}j==i' $file)
        vidTitle=$(echo $line | cut -d '"' -f 6)
#this line is most likely the culprit for blank prints if fields change
        echo $vidTitle
        printf "$vidTitle\r\n" >> "$outfile"
done

rm "$file"

####
#Add extra formatting:
#name of the playlist (bolded and underlined), the author/Channel (on the next line), and then "Retrieved From" and the URL
####

#Look into something like this:
#https://web.archive.org/web/20180309061900/https://archive.zhimingwang.org/blog/2014-11-05-list-youtube-playlist-with-youtube-dl.html
#There are tons of other ways to do this using APIs and such
