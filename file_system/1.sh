#!/bin/sh
FILES_COUNT=`ls -p | grep -v / | wc -l`
FOLDERS_COUNT=`ls -p | grep / | wc -l`
echo "Files count: $FILES_COUNT"
echo "Folder count: $FOLDERS_COUNT"
