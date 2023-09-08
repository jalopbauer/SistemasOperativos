#!/bin/sh
ls -lp | sed '1d' | grep -v / | sort -r -h -k 5 | head -5 | awk '{print $9}'