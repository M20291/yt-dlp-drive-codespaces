#!/bin/bash

# ׳¡׳§׳¨׳™׳₪׳˜ ׳‘׳“׳™׳§׳” ׳₪׳©׳•׳˜ ׳׳”׳•׳¨׳“׳× ׳¡׳¨׳˜׳•׳ (׳׳׳ ׳”׳¢׳׳׳” ׳-Drive)

echo "=========================================="
echo "   Video Download Test - No Drive Upload"
echo "=========================================="
echo ""

# ׳§׳¨׳™׳׳× ׳₪׳¨׳׳˜׳¨׳™׳ ׳׳”׳¡׳‘׳™׳‘׳” ׳׳• ׳׳§׳•׳‘׳¥ config
VIDEO_URL="${VIDEO_URL:-$(cat config.json 2>/dev/null | grep -o '"video_url"[^,]*' | cut -d'"' -f4)}"
PLATFORM="${PLATFORM:-$(cat config.json 2>/dev/null | grep -o '"platform"[^,]*' | cut -d'"' -f4)}"

# ׳¢׳¨׳›׳™ ׳‘׳¨׳™׳¨׳× ׳׳—׳“׳
PLATFORM="${PLATFORM:-youtube}"

# ׳׳ ׳׳™׳ ׳₪׳¨׳׳˜׳¨׳™׳ ׳׳”׳¡׳‘׳™׳‘׳”, ׳¦׳
if [ -z "$VIDEO_URL" ]; then
    echo "ג ׳׳ ׳¡׳•׳₪׳§ ׳§׳™׳©׳•׳¨ ׳׳¡׳¨׳˜׳•׳"
    echo "ג ן¸  ׳׳ ׳ ׳”׳’׳“׳¨ ׳׳× VIDEO_URL ׳‘׳¡׳‘׳™׳‘׳” ׳׳• ׳‘׳§׳•׳‘׳¥ config.json"
    exit 1
fi

echo "נ¥ ׳₪׳׳˜׳₪׳•׳¨׳׳”: $PLATFORM"
echo "נ”— ׳§׳™׳©׳•׳¨: $VIDEO_URL"
echo ""

# ׳‘׳“׳™׳§׳” ׳׳ Python3 ׳׳•׳×׳§׳
if ! command -v python3 &> /dev/null; then
    echo "ג Python3 ׳׳ ׳׳•׳×׳§׳. ׳׳×׳§׳™׳..."
    sudo apt-get update
    sudo apt-get install -y python3 python3-pip
else
    echo "ג… Python3 ׳׳•׳×׳§׳: $(python3 --version)"
fi

# ׳‘׳“׳™׳§׳” ׳׳ yt-dlp ׳׳•׳×׳§׳
if ! command -v yt-dlp &> /dev/null; then
    echo "ג yt-dlp ׳׳ ׳׳•׳×׳§׳. ׳׳×׳§׳™׳ ׳‘׳׳•׳₪׳ ׳׳§׳•׳׳™..."
    pip3 install --user yt-dlp
    export PATH="$HOME/.local/bin:$PATH"
else
    echo "ג… yt-dlp ׳׳•׳×׳§׳: $(yt-dlp --version)"
fi

# ׳™׳¦׳™׳¨׳× ׳×׳™׳§׳™׳™׳” ׳–׳׳ ׳™׳×
TEMP_DIR=$(mktemp -d)
echo "נ“ ׳×׳™׳§׳™׳™׳” ׳–׳׳ ׳™׳×: $TEMP_DIR"

# ׳”׳•׳¨׳“׳× ׳”׳§׳‘׳¦׳™׳ ׳¢׳ yt-dlp
echo ""
echo "ג¬‡ן¸  ׳׳×׳—׳™׳ ׳”׳•׳¨׳“׳” ׳-$PLATFORM..."
if [ "$PLATFORM" = "youtube" ]; then
    python3 -m yt_dlp -f "best[ext=mp4]" -o "$TEMP_DIR/%(title)s.%(ext)s" "$VIDEO_URL"
else
    python3 -m yt_dlp -f "best[ext=mp4]" -o "$TEMP_DIR/%(title)s.%(ext)s" "$VIDEO_URL"
fi

# ׳—׳™׳₪׳•׳© ׳›׳ ׳”׳§׳‘׳¦׳™׳ ׳©׳”׳•׳¨׳“׳•
echo ""
echo "נ” ׳׳—׳₪׳© ׳׳× ׳”׳§׳‘׳¦׳™׳ ׳©׳”׳•׳¨׳“׳•..."
DOWNLOADED_FILES=($(find "$TEMP_DIR" -type f -not -name ".*"))

if [ ${#DOWNLOADED_FILES[@]} -eq 0 ]; then
    echo "ג ׳׳ ׳ ׳׳¦׳׳• ׳§׳‘׳¦׳™׳ ׳©׳”׳•׳¨׳“׳•"
    rm -rf "$TEMP_DIR"
    exit 1
fi

echo "ג… ׳ ׳׳¦׳׳• ${#DOWNLOADED_FILES[@]} ׳§׳‘׳¦׳™׳"

# ׳”׳¦׳’׳× ׳₪׳¨׳˜׳™ ׳”׳§׳‘׳¦׳™׳
echo ""
echo "נ“‹ ׳₪׳¨׳˜׳™ ׳”׳§׳‘׳¦׳™׳:"
for file in "${DOWNLOADED_FILES[@]}"; do
    echo "  - $(basename "$file") ($(du -h "$file" | cut -f1))"
done

# ׳™׳¦׳™׳¨׳× ׳§׳•׳‘׳¥ ׳×׳•׳¦׳׳•׳×
echo ""
echo "נ“ ׳™׳•׳¦׳¨ ׳§׳•׳‘׳¥ ׳×׳•׳¦׳׳•׳×..."
cat > download_results.json << EOF
{
  "success": true,
  "platform": "$PLATFORM",
  "video_url": "$VIDEO_URL",
  "downloaded_files": [
$(for file in "${DOWNLOADED_FILES[@]}"; do
    echo "    {\"name\": \"$(basename "$file")\", \"size\": \"$(du -h "$file" | cut -f1)\"},"
done | sed '$ s/,$//')
  ],
  "timestamp": "$(date -Iseconds)",
  "note": "Files downloaded but not uploaded to Drive (test mode)"
}
EOF

echo "ג… ׳×׳•׳¦׳׳•׳× ׳ ׳©׳׳¨׳• ׳‘-download_results.json"

# ׳ ׳™׳§׳•׳™ ׳×׳™׳§׳™׳™׳” ׳–׳׳ ׳™׳×
echo ""
echo "נ§¹ ׳׳ ׳§׳” ׳×׳™׳§׳™׳™׳” ׳–׳׳ ׳™׳×..."
rm -rf "$TEMP_DIR"

echo ""
echo "=========================================="
echo "   ׳”׳”׳•׳¨׳“׳” ׳”׳•׳©׳׳׳” ׳‘׳”׳¦׳׳—׳”!"
echo "=========================================="
