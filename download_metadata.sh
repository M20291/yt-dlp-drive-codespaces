#!/bin/bash

echo "=========================================="
echo "   Video Metadata Downloader"
echo "=========================================="
echo ""

# ׳§׳¨׳™׳׳× ׳›׳×׳•׳‘׳× ׳¡׳¨׳˜׳•׳ ׳׳”-config
VIDEO_URL=$(cat config.json | grep -o '"video_url"[^,]*' | cut -d'"' -f4)

if [ -z "$VIDEO_URL" ]; then
    echo "ג No video URL found in config.json"
    exit 1
fi

echo "נ”— Video URL: $VIDEO_URL"
echo ""

# ׳§׳‘׳׳× ׳׳˜׳-׳“׳׳˜׳” ׳‘׳׳‘׳“
echo "נ“ Getting video metadata..."
python3 -m yt_dlp --dump-json "$VIDEO_URL" > video_metadata.json

# ׳—׳™׳׳•׳¥ ׳׳™׳“׳¢ ׳‘׳¡׳™׳¡׳™
TITLE=$(python3 -c "import json; data=json.load(open('video_metadata.json')); print(data.get('title', 'Unknown'))")
DURATION=$(python3 -c "import json; data=json.load(open('video_metadata.json')); print(data.get('duration', 'Unknown'))")
VIEW_COUNT=$(python3 -c "import json; data=json.load(open('video_metadata.json')); print(data.get('view_count', 'Unknown'))")
UPLOADER=$(python3 -c "import json; data=json.load(open('video_metadata.json')); print(data.get('uploader', 'Unknown'))")

echo "נ“¹ Title: $TITLE"
echo "ג±ן¸  Duration: $DURATION seconds"
echo "נ‘ן¸  View count: $VIEW_COUNT"
echo "נ‘₪ Uploader: $UPLOADER"
echo ""

# ׳™׳¦׳™׳¨׳× ׳§׳•׳‘׳¥ ׳×׳•׳¦׳׳”
cat > metadata_result.json << EOF
{
  "success": true,
  "video_url": "$VIDEO_URL",
  "title": "$TITLE",
  "duration": $DURATION,
  "view_count": $VIEW_COUNT,
  "uploader": "$UPLOADER",
  "timestamp": "$(date -Iseconds)"
}
EOF

echo "ג… Metadata saved to metadata_result.json"
cat metadata_result.json

echo ""
echo "=========================================="
echo "   Metadata download completed!"
echo "=========================================="
