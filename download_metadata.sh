#!/bin/bash
echo "Video URL: $VIDEO_URL"
echo "Downloading video..."
python3 -m yt_dlp "$VIDEO_URL" -o "video.%(ext)s" 2>&1
DOWNLOAD_EXIT_CODE=$?
echo "Download exit code: $DOWNLOAD_EXIT_CODE"
echo "Download complete"

# Upload to Google Drive using rclone
if [ -n "$GDRIVE_CONFIG" ]; then
  echo "Uploading to Google Drive..."
  echo "$GDRIVE_CONFIG" | base64 -d > rclone.conf
  # Find any file starting with "video"
  VIDEO_FILE=$(ls -t video* 2>/dev/null | head -1)
  if [ -n "$VIDEO_FILE" ]; then
    echo "Found video file: $VIDEO_FILE"
    rclone copy "$VIDEO_FILE" gdrive: --config rclone.conf
    RCLONE_EXIT_CODE=$?
    echo "rclone exit code: $RCLONE_EXIT_CODE"
    if [ $RCLONE_EXIT_CODE -eq 0 ]; then
      echo "Upload complete"
      # Create result file with upload info
      echo "{\"video_url\":\"$VIDEO_URL\",\"uploaded_file\":\"$VIDEO_FILE\",\"timestamp\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",\"success\":true}" > drive_result.json
    else
      echo "Upload failed with exit code: $RCLONE_EXIT_CODE"
      echo "{\"video_url\":\"$VIDEO_URL\",\"error\":\"rclone upload failed with exit code $RCLONE_EXIT_CODE\",\"timestamp\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",\"success\":false}" > drive_result.json
    fi
  else
    echo "No video file found to upload"
    echo "Listing all files in directory:"
    ls -la
    echo "{\"video_url\":\"$VIDEO_URL\",\"error\":\"No video file found\",\"timestamp\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",\"success\":false}" > drive_result.json
  fi
else
  echo "No Google Drive config provided"
  echo "{\"video_url\":\"$VIDEO_URL\",\"error\":\"No Google Drive config\",\"timestamp\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",\"success\":false}" > drive_result.json
fi