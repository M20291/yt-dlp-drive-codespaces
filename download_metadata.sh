#!/bin/bash
echo "Video URL: $VIDEO_URL"
python3 -m yt_dlp --dump-json "$VIDEO_URL" > video_metadata.json
echo "Done"