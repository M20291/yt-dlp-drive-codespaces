#!/bin/bash

echo "=========================================="
echo "   Testing yt-dlp installation"
echo "=========================================="
echo ""

# ׳‘׳“׳™׳§׳” ׳׳ Python3 ׳׳•׳×׳§׳
if command -v python3 &> /dev/null; then
    echo "ג… Python3 installed: $(python3 --version)"
else
    echo "ג Python3 not found"
    exit 1
fi

# ׳‘׳“׳™׳§׳” ׳׳ yt-dlp ׳׳•׳×׳§׳
if python3 -m yt_dlp --version &> /dev/null; then
    echo "ג… yt-dlp installed: $(python3 -m yt_dlp --version)"
else
    echo "ג yt-dlp not found"
    exit 1
fi

# ׳™׳¦׳™׳¨׳× ׳§׳•׳‘׳¥ ׳×׳•׳¦׳׳”
echo "Creating result file..."
cat > test_result.txt << EOF
Test completed successfully!
Timestamp: $(date -Iseconds)
Python: $(python3 --version)
yt-dlp: $(python3 -m yt_dlp --version)
EOF

echo "ג… Result file created: test_result.txt"
cat test_result.txt

echo ""
echo "=========================================="
echo "   All checks passed!"
echo "=========================================="
