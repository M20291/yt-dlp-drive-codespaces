#!/bin/bash
echo "Video URL: $VIDEO_URL"
echo "Downloading video..."
python3 -m yt_dlp "$VIDEO_URL" -o "video.%(ext)s"
echo "Download complete"