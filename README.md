# YouTube to Drive via Codespaces

׳׳¢׳¨׳›׳× ׳׳•׳˜׳•׳׳˜׳™׳× ׳׳”׳•׳¨׳“׳× ׳¡׳¨׳˜׳•׳ ׳™׳ ׳-YouTube/Vimeo ׳•׳”׳¢׳׳׳” ׳-Google Drive ׳“׳¨׳ GitHub Codespaces.

## נ¯ ׳׳™׳ ׳–׳” ׳¢׳•׳‘׳“

1. ׳”׳׳©׳×׳׳© ׳׳₪׳¢׳™׳ ׳׳× ׳¡׳§׳¨׳™׳₪׳˜ ׳”׳˜׳¨׳™׳’׳¨ ׳¢׳ ׳§׳™׳©׳•׳¨ ׳׳¡׳¨׳˜׳•׳
2. ׳”׳¡׳§׳¨׳™׳₪׳˜ ׳׳¢׳“׳›׳ ׳׳× `config.json` ׳‘-repository
3. ׳”׳¡׳§׳¨׳™׳₪׳˜ ׳™׳•׳¦׳¨ Codespace ׳—׳“׳© ׳“׳¨׳ GitHub API
4. ׳”-Codespace ׳¨׳¥ ׳׳•׳˜׳•׳׳˜׳™׳× ׳׳× `youtube_to_drive.sh`
5. ׳”׳¡׳§׳¨׳™׳₪׳˜ ׳׳•׳¨׳™׳“ ׳׳× ׳”׳¡׳¨׳˜׳•׳ ׳•׳׳¢׳׳” ׳׳•׳×׳• ׳-Google Drive
6. ׳”׳׳©׳×׳׳© ׳׳§׳‘׳ ׳׳× ׳”׳§׳™׳©׳•׳¨ ׳׳§׳•׳‘׳¥ ׳‘-Drive

## נ“‹ ׳“׳¨׳™׳©׳•׳× ׳׳•׳§׳“׳׳•׳×

- GitHub token ׳¢׳ ׳”׳¨׳©׳׳•׳× `codespace` ׳•-`repo`
- Google Drive OAuth credentials (׳׳•׳’׳“׳¨׳™׳ ׳›׳׳©׳×׳ ׳™ ׳¡׳‘׳™׳‘׳”)
- Node.js ׳׳”׳¨׳¦׳× ׳¡׳§׳¨׳™׳₪׳˜ ׳”׳˜׳¨׳™׳’׳¨

## נ€ ׳©׳™׳׳•׳©

### 1. ׳”׳’׳“׳¨׳× ׳׳©׳×׳ ׳™ ׳¡׳‘׳™׳‘׳”

׳”׳’׳“׳¨ ׳׳× ׳”׳׳©׳×׳ ׳™׳ ׳”׳‘׳׳™׳ ׳‘׳¡׳‘׳™׳‘׳” ׳©׳׳ ׳׳• ׳‘-devcontainer:

```bash
export DRIVE_TOKEN="your_google_oauth_token"
export DRIVE_REFRESH_TOKEN="your_google_refresh_token"
export DRIVE_CLIENT_ID="your_google_client_id"
export DRIVE_CLIENT_SECRET="your_google_client_secret"
```

### 2. ׳”׳₪׳¢׳׳× ׳”׳׳¢׳¨׳›׳×

```bash
node trigger_download.js <video_url> [platform] [cookies]
```

׳“׳•׳’׳׳׳•׳×:

```bash
# YouTube ׳¢׳ cookies
node trigger_download.js "https://www.youtube.com/watch?v=VIDEO_ID" youtube "cookies_content"

# YouTube ׳‘׳׳™ cookies
node trigger_download.js "https://www.youtube.com/watch?v=VIDEO_ID"

# Vimeo
node trigger_download.js "https://vimeo.com/VIDEO_ID" vimeo "cookies_content"
```

## נ“ ׳׳‘׳ ׳” ׳”׳§׳‘׳¦׳™׳

```
.
ג”ג”€ג”€ youtube_to_drive.sh          # ׳¡׳§׳¨׳™׳₪׳˜ ׳”׳•׳¨׳“׳” ׳•׳”׳¢׳׳׳”
ג”ג”€ג”€ trigger_download.js         # ׳¡׳§׳¨׳™׳₪׳˜ ׳˜׳¨׳™׳’׳¨ ׳“׳¨׳ GitHub API
ג”ג”€ג”€ config.json                 # ׳§׳•׳‘׳¥ ׳”׳’׳“׳¨׳•׳× (׳׳¢׳•׳“׳›׳ ׳׳•׳˜׳•׳׳˜׳™׳×)
ג”ג”€ג”€ .devcontainer/
ג”‚   ג””ג”€ג”€ devcontainer.json       # ׳”׳’׳“׳¨׳•׳× Codespace
ג””ג”€ג”€ README.md                   # ׳”׳¡׳‘׳¨ ׳–׳”
```

## נ”§ ׳׳™׳ ׳–׳” ׳¢׳•׳‘׳“

### ׳¡׳§׳¨׳™׳₪׳˜ ׳”׳˜׳¨׳™׳’׳¨ (trigger_download.js)

1. ׳׳§׳‘׳ ׳₪׳¨׳׳˜׳¨׳™׳: ׳§׳™׳©׳•׳¨, ׳₪׳׳˜׳₪׳•׳¨׳׳”, cookies
2. ׳׳¢׳“׳›׳ ׳׳× `config.json` ׳‘-repository
3. ׳™׳•׳¦׳¨ Codespace ׳—׳“׳© ׳“׳¨׳ GitHub API
4. ׳׳—׳–׳™׳¨ ׳׳× ׳₪׳¨׳˜׳™ ׳”-Codespace

### ׳¡׳§׳¨׳™׳₪׳˜ ׳”׳”׳•׳¨׳“׳” (youtube_to_drive.sh)

1. ׳§׳•׳¨׳ ׳₪׳¨׳׳˜׳¨׳™׳ ׳-`config.json` ׳׳• ׳׳¡׳‘׳™׳‘׳”
2. ׳׳×׳§׳™׳ ׳׳× ׳”׳›׳׳™׳ ׳”׳ ׳“׳¨׳©׳™׳ (yt-dlp, Deno, Node.js)
3. ׳׳•׳¨׳™׳“ ׳׳× ׳”׳¡׳¨׳˜׳•׳ ׳¢׳ yt-dlp
4. ׳׳¢׳׳” ׳׳× ׳”׳§׳•׳‘׳¥ ׳-Google Drive
5. ׳©׳•׳׳¨ ׳׳× ׳”׳×׳•׳¦׳׳•׳× ׳‘-`upload_results.json`

### DevContainer

׳”-devcontainer ׳׳•׳’׳“׳¨ ׳׳¨׳•׳¥ ׳׳•׳˜׳•׳׳˜׳™׳× ׳׳× ׳”׳¡׳§׳¨׳™׳₪׳˜ ׳“׳¨׳ `postCreateCommand`:

```json
{
  "postCreateCommand": "chmod +x youtube_to_drive.sh && bash youtube_to_drive.sh"
}
```

## נ× ׳׳¡׳˜׳¨׳˜׳’׳™׳™׳× ׳”׳¢׳•׳’׳™׳•׳×

- **YouTube**: ׳“׳•׳¨׳© ׳§׳•׳‘׳¥ cookies ׳‘׳©׳ `www.youtube.com_cookies.txt` ׳•׳’׳ ׳׳× ׳”׳₪׳¨׳׳˜׳¨׳™׳ `--js-runtimes deno --remote-components ejs:github`
- **Vimeo**: ׳“׳•׳¨׳© ׳§׳•׳‘׳¥ cookies ׳‘׳©׳ `vimeo.com_cookies.txt` ׳׳׳ ׳₪׳¨׳׳˜׳¨׳™׳ ׳ ׳•׳¡׳₪׳™׳
- ׳”׳¢׳•׳’׳™׳•׳× ׳׳•׳¢׳‘׳¨׳•׳× ׳›׳׳—׳¨׳•׳–׳× ׳•׳ ׳©׳׳¨׳•׳× ׳›׳§׳•׳‘׳¥ ׳¢׳ ׳™׳“׳™ ׳”׳¡׳§׳¨׳™׳₪׳˜

## נ¯ ׳™׳×׳¨׳•׳ ׳•׳×

- ג… **׳׳•׳˜׳•׳׳¦׳™׳” ׳׳׳׳”** - ׳׳™׳ ׳¦׳•׳¨׳ ׳׳”׳™׳›׳ ׳¡ ׳׳׳¨׳—׳‘ ׳™׳“׳ ׳™׳×
- ג… **׳¢׳§׳™׳₪׳× ׳—׳¡׳™׳׳•׳×** - ׳¢׳•׳‘׳“ ׳“׳¨׳ GitHub API ׳’׳ ׳›׳©-CLI ׳—׳¡׳•׳
- ג… **׳¡׳‘׳™׳‘׳” ׳ ׳§׳™׳™׳”** - ׳›׳ ׳₪׳¢׳ Codespace ׳—׳“׳© ׳•׳ ׳§׳™
- ג… **׳”׳•׳¨׳“׳” ׳׳•׳˜׳•׳׳˜׳™׳× ׳-Drive** - ׳”׳§׳‘׳¦׳™׳ ׳ ׳©׳׳¨׳™׳ ׳‘-Cloud
- ג… **׳×׳׳™׳›׳” ׳‘׳₪׳׳˜׳₪׳•׳¨׳׳•׳×** - YouTube ׳•-Vimeo

## נ”’ ׳׳‘׳˜׳—׳”

- ׳”׳¡׳•׳“׳•׳× ׳©׳ Google Drive ׳׳•׳’׳“׳¨׳™׳ ׳›׳׳©׳×׳ ׳™ ׳¡׳‘׳™׳‘׳” ׳•׳׳ ׳‘׳§׳•׳“
- ׳”-repository ׳¦׳™׳‘׳•׳¨׳™ ׳׳‘׳ ׳׳׳ ׳¡׳•׳“׳•׳× ׳‘׳§׳•׳“
- ׳”-Codespaces ׳ ׳׳—׳§׳™׳ ׳׳—׳¨׳™ ׳©׳™׳׳•׳©

## נ“ ׳”׳¢׳¨׳•׳×

- ׳”׳¡׳™׳¡׳˜׳ ׳“׳•׳¨׳© GitHub token ׳¢׳ ׳”׳¨׳©׳׳•׳× ׳׳×׳׳™׳׳•׳×
- ׳™׳© ׳׳”׳’׳“׳™׳¨ ׳׳× ׳׳©׳×׳ ׳™ ׳”׳¡׳‘׳™׳‘׳” ׳©׳ Google Drive ׳׳₪׳ ׳™ ׳”׳©׳™׳׳•׳©
- ׳”׳©׳™׳׳•׳© ׳‘-Codespaces ׳¢׳׳•׳ ׳׳”׳™׳•׳× ׳‘׳×׳©׳׳•׳ ׳׳₪׳™ ׳”׳©׳™׳׳•׳©

## נ€ ׳׳¡׳™׳›׳•׳

׳׳¢׳¨׳›׳× ׳–׳• ׳׳׳₪׳©׳¨׳× ׳׳”׳•׳¨׳™׳“ ׳¡׳¨׳˜׳•׳ ׳™׳ ׳-YouTube/Vimeo ׳•׳׳”׳¢׳׳•׳× ׳׳•׳×׳ ׳-Google Drive ׳‘׳¦׳•׳¨׳” ׳׳•׳˜׳•׳׳˜׳™׳× ׳“׳¨׳ GitHub Codespaces, ׳×׳•׳ ׳¢׳§׳™׳₪׳× ׳׳’׳‘׳׳•׳× ׳¨׳©׳× ׳•׳©׳™׳׳•׳© ׳‘-GitHub API.