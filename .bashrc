#!/bin/bash

# ׳”׳¨׳¦׳” ׳׳•׳˜׳•׳׳˜׳™׳× ׳©׳ ׳”׳¡׳§׳¨׳™׳₪׳˜ ׳›׳©׳׳×׳—׳‘׳¨׳™׳ ׳-terminal
if [ -f "download_metadata.sh" ] && [ -f "config.json" ]; then
    if [ ! -f "metadata_result.json" ]; then
        echo "Running metadata download script..."
        bash download_metadata.sh
    fi
fi
