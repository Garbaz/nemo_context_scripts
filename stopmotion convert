#!/bin/bash

FRAMERATE=8

TMPFOLDER=".convert_tmp"
FORMATTINGSTRING="%06d"

mkdir "$TMPFOLDER"
cd "$TMPFOLDER" || exit
i=0
ext=${1##*.}
for f in "$@";do
    ipadded=$(printf "$FORMATTINGSTRING" $i)
    ln -s "../$f" "$ipadded.$ext"
    i=$((i+1))
done
cd ..
ffmpeg -r "$FRAMERATE" -i "$TMPFOLDER/$FORMATTINGSTRING.$ext" -vcodec libx264 out.mp4
rm -r "$TMPFOLDER"