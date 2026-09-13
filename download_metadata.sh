#!/bin/bash
echo "Video URL: $VIDEO_URL"
echo "Downloading video..."
python3 -m yt_dlp "$VIDEO_URL" -o "video.%(ext)s"
echo "Download complete"

# Upload to Google Drive using rclone
if [ -n "$GDRIVE_CONFIG" ]; then
  echo "Uploading to Google Drive..."
  echo "$GDRIVE_CONFIG" | base64 -d > rclone.conf
  rclone copy video.* gdrive: --config rclone.conf
  echo "Upload complete"
else
  echo "No Google Drive config provided"
fi