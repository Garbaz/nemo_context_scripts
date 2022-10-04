#!/bin/bash
{

OUTFILE="000_join_videos_$DATE-$RANDOM.mp4"

melt "$@" -consumer avformat:"$OUTFILE" acodec=libmp3lame vcodec=libx264

} >> join_videos_log.txt 2>&1