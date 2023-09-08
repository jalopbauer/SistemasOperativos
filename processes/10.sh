#!/bin/sh
top -o %MEM | sed -n -e '8{p;q}'