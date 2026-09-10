#!/bin/bash

# ׳¡׳§׳¨׳™׳₪׳˜ ׳׳”׳•׳¨׳“׳” ׳-YouTube/Vimeo ׳•׳”׳¢׳׳׳” ׳-Google Drive
# ׳’׳¨׳¡׳” ׳׳•׳˜׳•׳׳˜׳™׳× ׳׳₪׳¢׳•׳׳” ׳“׳¨׳ GitHub API

echo "=========================================="
echo "   Video to Drive - Automatic Script"
echo "=========================================="
echo ""

# ׳§׳¨׳™׳׳× ׳₪׳¨׳׳˜׳¨׳™׳ ׳׳”׳¡׳‘׳™׳‘׳” ׳׳• ׳׳§׳•׳‘׳¥ config
VIDEO_URL="${VIDEO_URL:-$(cat config.json 2>/dev/null | grep -o '"video_url"[^,]*' | cut -d'"' -f4)}"
PLATFORM="${PLATFORM:-$(cat config.json 2>/dev/null | grep -o '"platform"[^,]*' | cut -d'"' -f4)}"
COOKIES_CONTENT="${COOKIES_CONTENT:-$(cat config.json 2>/dev/null | grep -o '"cookies"[^,]*' | cut -d'"' -f4)}"

# ׳¢׳¨׳›׳™ ׳‘׳¨׳™׳¨׳× ׳׳—׳“׳
PLATFORM="${PLATFORM:-youtube}"

# ׳׳ ׳׳™׳ ׳₪׳¨׳׳˜׳¨׳™׳ ׳׳©׳•׳ ׳׳§׳•׳, ׳¦׳
if [ -z "$VIDEO_URL" ]; then
    echo "ג ׳׳ ׳¡׳•׳₪׳§ ׳§׳™׳©׳•׳¨ ׳׳¡׳¨׳˜׳•׳"
    echo "ג ן¸  ׳׳ ׳ ׳”׳’׳“׳¨ ׳׳× VIDEO_URL ׳‘׳¡׳‘׳™׳‘׳” ׳׳• ׳‘׳§׳•׳‘׳¥ config.json"
    exit 1
fi
VIDEO_URL="${VIDEO_URL:-}"

if [ -z "$VIDEO_URL" ]; then
    echo "ג ׳׳ ׳¡׳•׳₪׳§ ׳§׳™׳©׳•׳¨ ׳׳¡׳¨׳˜׳•׳"
    echo "ג ן¸  ׳׳ ׳ ׳”׳’׳“׳¨ ׳׳× VIDEO_URL ׳‘׳¡׳‘׳™׳‘׳” ׳׳• ׳‘׳§׳•׳‘׳¥ config.json"
    exit 1
fi

echo "נ¥ ׳₪׳׳˜׳₪׳•׳¨׳׳”: $PLATFORM"
echo "נ”— ׳§׳™׳©׳•׳¨: $VIDEO_URL"
echo ""

# ׳‘׳“׳™׳§׳” ׳׳ Python ׳׳•׳×׳§׳
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

# ׳‘׳“׳™׳§׳” ׳׳ Deno ׳׳•׳×׳§׳
if ! command -v deno &> /dev/null; then
    echo "ג Deno ׳׳ ׳׳•׳×׳§׳. ׳׳×׳§׳™׳..."
    curl -fsSL https://deno.land/install.sh | sh
    export PATH="$HOME/.deno/bin:$PATH"
else
    echo "ג… Deno ׳׳•׳×׳§׳: $(deno --version)"
fi

# ׳‘׳“׳™׳§׳” ׳׳ Node.js ׳׳•׳×׳§׳
if ! command -v node &> /dev/null; then
    echo "ג Node.js ׳׳ ׳׳•׳×׳§׳. ׳׳×׳§׳™׳..."
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt-get install -y nodejs
else
    echo "ג… Node.js ׳׳•׳×׳§׳: $(node --version)"
fi

# ׳‘׳“׳™׳§׳” ׳׳ npm ׳׳•׳×׳§׳
if ! command -v npm &> /dev/null; then
    echo "ג npm ׳׳ ׳׳•׳×׳§׳. ׳׳×׳§׳™׳..."
    sudo apt-get install -y npm
else
    echo "ג… npm ׳׳•׳×׳§׳: $(npm --version)"
fi

# ׳‘׳“׳™׳§׳” ׳׳ googleapis ׳׳•׳×׳§׳
if [ ! -d "node_modules/googleapis" ]; then
    echo "ג googleapis ׳׳ ׳׳•׳×׳§׳. ׳׳×׳§׳™׳..."
    npm install googleapis
else
    echo "ג… googleapis ׳׳•׳×׳§׳"
fi

# ׳™׳¦׳™׳¨׳× package.json ׳¢׳ type: module ׳׳ ׳׳ ׳§׳™׳™׳
if [ ! -f "package.json" ]; then
    echo "נ“ ׳™׳•׳¦׳¨ package.json..."
    echo '{"type": "module"}' > package.json
else
    if ! grep -q '"type": "module"' package.json; then
        echo "נ“ ׳׳¢׳“׳›׳ package.json..."
        temp=$(cat package.json)
        echo "$temp" | sed '0,/{/s/{/{\n  "type": "module",/' > package.json.tmp
        mv package.json.tmp package.json
    fi
fi

# ׳™׳¦׳™׳¨׳× ׳§׳•׳‘׳¥ cookies ׳׳”׳₪׳¨׳׳˜׳¨
if [ -n "$COOKIES_CONTENT" ]; then
    echo "נ× ׳™׳•׳¦׳¨ ׳§׳•׳‘׳¥ cookies..."
    if [ "$PLATFORM" = "youtube" ]; then
        COOKIES_FILE="www.youtube.com_cookies.txt"
    else
        COOKIES_FILE="vimeo.com_cookies.txt"
    fi
    echo "$COOKIES_CONTENT" > "$COOKIES_FILE"
    echo "ג… ׳§׳•׳‘׳¥ cookies ׳ ׳•׳¦׳¨: $COOKIES_FILE"
else
    echo "ג ן¸  ׳׳ ׳¡׳•׳₪׳§ ׳×׳•׳›׳ cookies"
    echo "ג ן¸  ׳”׳”׳•׳¨׳“׳” ׳¢׳׳•׳׳” ׳׳”׳™׳›׳©׳ ׳‘׳’׳׳ ׳”׳’׳‘׳׳•׳×"
    COOKIES_FILE=""
fi

# ׳™׳¦׳™׳¨׳× ׳¡׳§׳¨׳™׳₪׳˜ ׳”׳”׳¢׳׳׳” ׳-Drive
cat > upload_to_drive.js << 'EOF'
import { google } from 'googleapis';
import { readFileSync } from 'fs';
import { Readable } from 'stream';

// OAuth credentials from environment variables
const credentials = {
  token: process.env.DRIVE_TOKEN,
  refresh_token: process.env.DRIVE_REFRESH_TOKEN,
  token_uri: "https://oauth2.googleapis.com/token",
  client_id: process.env.DRIVE_CLIENT_ID,
  client_secret: process.env.DRIVE_CLIENT_SECRET,
  scopes: [
    "https://www.googleapis.com/auth/drive.file",
    "https://www.googleapis.com/auth/drive.metadata.readonly"
  ]
};

// Initialize OAuth2 client
const oauth2Client = new google.auth.OAuth2(
  credentials.client_id,
  credentials.client_secret,
  credentials.token_uri
);

oauth2Client.setCredentials({
  refresh_token: credentials.refresh_token,
});

// Initialize Drive client
const drive = google.drive({ version: 'v3', auth: oauth2Client });

// File to upload
const filePath = process.argv[2];
const fileName = process.argv[3] || 'downloaded_file';

async function uploadFile() {
  try {
    // Refresh access token
    const { credentials } = await oauth2Client.refreshAccessToken();
    console.log('ג… Token refreshed successfully');

    // Read file
    const fileBuffer = readFileSync(filePath);
    console.log('ג… File read successfully');

    // Create stream from buffer
    const bufferStream = new Readable();
    bufferStream.push(fileBuffer);
    bufferStream.push(null);

    // Determine MIME type
    let mimeType = 'application/octet-stream';
    if (fileName.endsWith('.pdf')) mimeType = 'application/pdf';
    else if (fileName.endsWith('.mp4')) mimeType = 'video/mp4';
    else if (fileName.endsWith('.mp3')) mimeType = 'audio/mpeg';
    else if (fileName.endsWith('.jpg') || fileName.endsWith('.jpeg')) mimeType = 'image/jpeg';
    else if (fileName.endsWith('.png')) mimeType = 'image/png';
    else if (fileName.endsWith('.webm')) mimeType = 'video/webm';

    // Upload to Drive
    const result = await drive.files.create({
      resource: {
        name: fileName,
      },
      media: {
        mimeType: mimeType,
        body: bufferStream,
      },
      fields: 'id, name, webViewLink',
    });

    console.log('נ‰ File uploaded successfully!');
    console.log('נ“ File ID:', result.data.id);
    console.log('נ“„ File Name:', result.data.name);
    console.log('נ”— Web View Link:', result.data.webViewLink);
    
    // Return result as JSON for automation
    console.log(JSON.stringify({
      success: true,
      file_id: result.data.id,
      file_name: result.data.name,
      web_view_link: result.data.webViewLink
    }));
  } catch (error) {
    console.error('ג Error uploading file:', error.message);
    console.log(JSON.stringify({
      success: false,
      error: error.message
    }));
    process.exit(1);
  }
}

uploadFile();
EOF

echo ""
echo "=========================================="
echo "   ׳”׳×׳§׳ ׳” ׳”׳•׳©׳׳׳” ׳‘׳”׳¦׳׳—׳”!"
echo "=========================================="
echo ""

# ׳™׳¦׳™׳¨׳× ׳×׳™׳§׳™׳™׳” ׳–׳׳ ׳™׳×
TEMP_DIR=$(mktemp -d)
echo "נ“ ׳×׳™׳§׳™׳™׳” ׳–׳׳ ׳™׳×: $TEMP_DIR"

# ׳”׳•׳¨׳“׳× ׳”׳§׳‘׳¦׳™׳ ׳¢׳ yt-dlp
echo ""
echo "ג¬‡ן¸  ׳׳×׳—׳™׳ ׳”׳•׳¨׳“׳” ׳-$PLATFORM..."
if [ "$PLATFORM" = "youtube" ]; then
    if [ -n "$COOKIES_FILE" ]; then
        python3 -m yt_dlp --cookies "$COOKIES_FILE" --js-runtimes deno --remote-components ejs:github -f "best[ext=mp4]" -o "$TEMP_DIR/%(title)s.%(ext)s" "$VIDEO_URL"
    else
        python3 -m yt_dlp -f "best[ext=mp4]" -o "$TEMP_DIR/%(title)s.%(ext)s" "$VIDEO_URL"
    fi
else
    if [ -n "$COOKIES_FILE" ]; then
        python3 -m yt_dlp --cookies "$COOKIES_FILE" -f "best[ext=mp4]" -o "$TEMP_DIR/%(title)s.%(ext)s" "$VIDEO_URL"
    else
        python3 -m yt_dlp -f "best[ext=mp4]" -o "$TEMP_DIR/%(title)s.%(ext)s" "$VIDEO_URL"
    fi
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

# ׳”׳¢׳׳׳× ׳›׳ ׳”׳§׳‘׳¦׳™׳ ׳-Google Drive
echo ""
echo "ג˜ן¸  ׳׳¢׳׳” ׳׳× ׳”׳§׳‘׳¦׳™׳ ׳-Google Drive..."
SUCCESS_COUNT=0
FAIL_COUNT=0
UPLOAD_RESULTS=()

for file in "${DOWNLOADED_FILES[@]}"; do
    echo "נ“₪ ׳׳¢׳׳”: $(basename "$file")"
    RESULT=$(node upload_to_drive.js "$file" "$(basename "$file")" 2>&1)
    if echo "$RESULT" | grep -q '"success":true'; then
        ((SUCCESS_COUNT++))
        UPLOAD_RESULTS+=("$RESULT")
    else
        ((FAIL_COUNT++))
        echo "ג ׳ ׳›׳©׳ ׳‘׳”׳¢׳׳׳”: $(basename "$file")"
        UPLOAD_RESULTS+=("$RESULT")
    fi
done

# ׳׳—׳™׳§׳× ׳”׳×׳™׳§׳™׳™׳” ׳”׳–׳׳ ׳™׳×
echo ""
echo "נ—‘ן¸  ׳׳•׳—׳§ ׳×׳™׳§׳™׳™׳” ׳–׳׳ ׳™׳×..."
rm -rf "$TEMP_DIR"

echo ""
echo "=========================================="
echo "   ׳×׳”׳׳™׳ ׳”׳•׳©׳׳!"
echo "=========================================="
echo "ג… ׳”׳•׳¢׳׳• ׳‘׳”׳¦׳׳—׳”: $SUCCESS_COUNT ׳§׳‘׳¦׳™׳"
echo "ג ׳ ׳›׳©׳׳•: $FAIL_COUNT ׳§׳‘׳¦׳™׳"

# ׳©׳׳™׳¨׳× ׳×׳•׳¦׳׳•׳× ׳”׳”׳¢׳׳׳” ׳׳§׳•׳‘׳¥
echo "[${UPLOAD_RESULTS[@]}]" > upload_results.json
echo "נ“ ׳×׳•׳¦׳׳•׳× ׳ ׳©׳׳¨׳• ׳-upload_results.json"