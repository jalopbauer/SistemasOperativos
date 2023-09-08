#!/bin/sh
ps aux --sort=-%mem | head -11 | tail -10 > memory.txt