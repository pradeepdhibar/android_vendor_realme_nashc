#!/bin/bash

PROP_FILE="proprietary-files.txt"
VENDOR_DIR="proprietary/"

echo "🔍 Checking files listed in $PROP_FILE..."

missing_count=0

while IFS= read -r line; do
    # Skip empty lines and comments
    [[ -z "$line" || "$line" =~ ^# ]] && continue

    # Extract path before ';' (if present)
    file=$(echo "$line" | cut -d ';' -f1)

    # Remove leading '-' if it's marked optional
    file=${file#-}

    # Check if file exists
    if [[ ! -f "$VENDOR_DIR/$file" ]]; then
        echo "❌ MISSING: $file"
        ((missing_count++))
    fi
done < "$PROP_FILE"

echo "✅ Check complete: $missing_count missing files."
