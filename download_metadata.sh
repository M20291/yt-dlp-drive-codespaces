#!/bin/bash
echo "Video URL: $VIDEO_URL"
echo "Checking if VIDEO_URL is set..."
if [ -z "$VIDEO_URL" ]; then
  echo "ERROR: VIDEO_URL is not set!"
  echo "{\"video_url\":\"\",\"error\":\"VIDEO_URL is not set\",\"timestamp\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",\"success\":false}" > drive_result.json
  exit 1
fi
echo "Downloading video..."
python3 -m yt_dlp "$VIDEO_URL" -o "video.%(ext)s"
DOWNLOAD_EXIT_CODE=$?
echo "Download exit code: $DOWNLOAD_EXIT_CODD"
if [ $DOWNLOAD_EXIT_CODE -ne 0 ]; then
  echo "ERROR: yt-dlp download failed with exit code $DOWNLOAD_EXIT_CODE"
  echo "{\"video_url\":\"$VIDEO_URL\",\"error\":\"yt-dlp download failed with exit code $DOWNLOAD_EXIT_CODE\",\"timestamp\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",\"success\":false}" > drive_result.json
  exit 1
fi
echo "Download complete"

# Upload to Google Drive using rclone
if [ -n "$GDRIVE_CONFIG" ]; then
  echo "Uploading to Google Drive..."
  echo "$GDRIVE_CONFIG" | base64 -d > rclone.conf
  # Find the most recently created video file
  VIDEO_FILE=$(ls -t *.mp4 *.mkv *.webm *.avi 2>/dev/null | head -1)
  if [ -n "$VIDEO_FILE" ]; then
    echo "Found video file: $VIDEO_FILE"
    rclone copy "$VIDEO_FILE" gdrive: --config rclone.conf
    echo "Upload complete"
    # Create result file with upload info
    echo "{\"video_url\":\"$VIDEO_URL\",\"uploaded_file\":\"$VIDEO_FILE\",\"timestamp\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",\"success\":true}" > drive_result.json
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