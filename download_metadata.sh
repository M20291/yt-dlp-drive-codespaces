#!/bin/bash
echo "Video URL: $VIDEO_URL"
echo "Downloading video..."
python3 -m yt_dlp "$VIDEO_URL" -o "video.%(ext)s" 2>&1
DOWNLOAD_EXIT_CODE=$?
echo "Download exit code: $DOWNLOAD_EXIT_CODE"
echo "Download complete"

# Upload to Google Drive using Google Drive API
if [ -n "$GDRIVE_CONFIG" ]; then
  echo "Uploading to Google Drive using API..."
  echo "$GDRIVE_CONFIG" | base64 -d > gdrive_config.json
  # Find any file starting with "video"
  VIDEO_FILE=$(ls -t video* 2>/dev/null | head -1)
  if [ -n "$VIDEO_FILE" ]; then
    echo "Found video file: $VIDEO_FILE"
    # Upload file using Python script with logging to file
    python3 << EOF 2>&1 | tee upload_log.txt
import json
import os
import sys
from google.oauth2.credentials import Credentials
from googleapiclient.discovery import build
from googleapiclient.http import MediaFileUpload
from google.auth.transport.requests import Request

try:
    # Load credentials
    with open('gdrive_config.json', 'r') as f:
        creds_data = json.load(f)
    
    print("Credentials loaded successfully")
    print(f"Client ID: {creds_data.get('client_id')}")
    print(f"Token URI: {creds_data.get('token_uri')}")
    print(f"Scopes: {creds_data.get('scopes')}")
    
    # Create credentials object with refresh token
    creds = Credentials(
        token=None,  # We'll refresh
        refresh_token=creds_data.get('refresh_token'),
        token_uri=creds_data.get('token_uri'),
        client_id=creds_data.get('client_id'),
        client_secret=creds_data.get('client_secret'),
        scopes=creds_data.get('scopes')
    )
    
    print("Credentials object created")
    
    # Refresh the token using the correct method
    print("Refreshing token...")
    creds.refresh(Request())
    print("Token refreshed successfully")
    
    # Create Drive API service
    print("Creating Drive API service...")
    service = build('drive', 'v3', credentials=creds)
    print("Drive API service created")
    
    # Upload file
    print(f"Uploading file: $VIDEO_FILE")
    file_metadata = {'name': '$VIDEO_FILE'}
    media = MediaFileUpload('$VIDEO_FILE', resumable=True)
    file = service.files().create(body=file_metadata, media_body=media, fields='id').execute()
    print(f"File ID: {file.get('id')}")
    print("Upload completed successfully")
    
except Exception as e:
    print(f"Error during upload: {str(e)}")
    import traceback
    traceback.print_exc()
    sys.exit(1)
EOF
    GDRIVE_EXIT_CODE=$?
    echo "gdrive upload exit code: $GDRIVE_EXIT_CODE"
    if [ $GDRIVE_EXIT_CODE -eq 0 ]; then
      echo "Upload complete"
      # Create result file with upload info
      echo "{\"video_url\":\"$VIDEO_URL\",\"uploaded_file\":\"$VIDEO_FILE\",\"timestamp\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",\"success\":true}" > drive_result.json
    else
      echo "Upload failed with exit code: $GDRIVE_EXIT_CODE"
      echo "{\"video_url\":\"$VIDEO_URL\",\"error\":\"gdrive upload failed with exit code $GDRIVE_EXIT_CODE\",\"timestamp\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",\"success\":false}" > drive_result.json
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