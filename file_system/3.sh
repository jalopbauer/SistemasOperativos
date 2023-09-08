#!/bin/sh
if [ $# -ne 1 ]; then
    echo "Usage: $0 <string>"
    exit 1
fi
QUANTITY=`ls -lp *.$1 | grep -v / | wc -l`
echo "Quantity: $QUANTITY"
echo "Files: "
ls -lp *.$1 | grep -v / | awk '{print $9}'