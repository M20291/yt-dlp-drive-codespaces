#!/bin/bash
echo "Video URL: $VIDEO_URL"
echo "Downloading video..."
python3 -m yt_dlp "$VIDEO_URL" -o "video.%(ext)s" 2>&1 | tee download_log.txt
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
    echo "{\"video_url\":\"$VIDEO_URL\",\"uploaded_file\":\"$VIDEO_FILE\",\"timestamp\":\"$(date -u +%Y-%m-%dT%H3¥4Ø”Õ7¥Â"ÅÂ'7V66W75Â#§G'VWÒ"âG&—fU÷&W7VÇBæ§6öà¢VÇ6P¢V6†ò$æòf–FVòf–ÆRf÷VæBFòWÆöB ¢V6†ò$Æ—7F–ærÆÂf–ÆW2–âF—&V7F÷'“¢ ¢Ç2ÖÆ¢V6†ò'µÂ'f–FVõ÷W&ÅÂ#¥Â"Ed”DTõõU$ÅÂ"ÅÂ&W'&÷%Â#¥Â$æòf–FVòf–ÆRf÷VæEÂ"ÅÂ'F–ÖW7F×Â#¥Â"B†FFR×R²U’ÒVÒÒVEBTƒ¢TÓ¢U5¢•Â"ÅÂ'7V66W75Â#¦fÇ6WÒ"âG&—fU÷&W7VÇBæ§6öà¢f¦VÇ6P¢V6†ò$æòvöövÆRG&—fR6öæf–r&÷f–FVB ¢V6†ò'µÂ'f–FVõ÷W&ÅÂ#¥Â"Ed”DTõõU$ÅÂ"ÅÂ&W'&÷%Â#¥Â$æòvöövÆRG&—fR6öæf–uÂ"ÅÂ'F–ÖW7F×Â#¥Â"B†FFR×R²U’ÒVÒÒVEBTƒ:SM‰MSz\",\"success\":false}" > drive_result.json
