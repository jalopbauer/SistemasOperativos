#!/bin/sh
if [ $# -ne 1 ]; then
    echo "Usage: $0 <string>"
    exit 1
fi
cp -r $1 $2