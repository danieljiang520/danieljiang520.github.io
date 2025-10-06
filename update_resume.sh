#!/bin/bash

# Script to update Daniel_Jiang_Stanford_Resume.pdf
# Usage: ./update_resume.sh [optional_filepath]
# If no filepath is provided, uses the most recently added file from ~/Downloads

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_FILE="$SCRIPT_DIR/files/Daniel_Jiang_Stanford_Resume.pdf"

# Check if a filepath argument was provided
if [ -n "$1" ]; then
    SOURCE_FILE="$1"
else
    # Find the most recently added file in ~/Downloads
    # Using -type f to only get files, not directories
    SOURCE_FILE=$(ls -t ~/Downloads/* 2>/dev/null | head -n 1)
    
    if [ -z "$SOURCE_FILE" ]; then
        echo "Error: No files found in ~/Downloads"
        exit 1
    fi
    
    echo "No file specified. Using most recent file from Downloads:"
    echo "  $SOURCE_FILE"
fi

# Check if source file exists
if [ ! -f "$SOURCE_FILE" ]; then
    echo "Error: File not found: $SOURCE_FILE"
    exit 1
fi

# Check if the file is a PDF
if [[ ! "$SOURCE_FILE" =~ \.pdf$ ]]; then
    echo "Error: File is not a PDF: $SOURCE_FILE"
    exit 1
fi

# Copy the file to the target location
cp "$SOURCE_FILE" "$TARGET_FILE"

if [ $? -eq 0 ]; then
    echo "✓ Successfully updated resume at: $TARGET_FILE"
else
    echo "Error: Failed to copy file"
    exit 1
fi

