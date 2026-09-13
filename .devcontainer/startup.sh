#!/bin/bash

# ׳¡׳§׳¨׳™׳₪׳˜ ׳”׳¨׳¦׳” ׳׳•׳˜׳•׳׳˜׳™׳× ׳©׳¨׳¥ ׳›׳ ׳₪׳¢׳ ׳©׳”-codespace ׳׳×׳—׳™׳
# ׳™׳•׳¦׳¨ ׳§׳•׳‘׳¥ lock ׳›׳“׳™ ׳׳׳ ׳•׳¢ ׳”׳¨׳¦׳” ׳›׳₪׳•׳׳”

LOCK_FILE="/tmp/metadata_script.lock"

if [ -f "$LOCK_FILE" ]; then
    echo "Script already running or completed"
    exit 0
fi

touch "$LOCK_FILE"

echo "=========================================="
echo "   Auto-run metadata download"
echo "=========================================="
echo ""

# ׳”׳׳×׳ ׳” ׳׳”׳×׳§׳ ׳” ׳׳”׳¡׳×׳™׳™׳
sleep 15

if [ -f "download_metadata.sh" ] && [ -f "config.json" ]; then
    echo "Running metadata download script..."
    bash download_metadata.sh
    echo "=========================================="
    echo "   Auto-run completed!"
    echo "=========================================="
else
    echo "Required files not found"
fi

rm "$LOCK_FILE"
