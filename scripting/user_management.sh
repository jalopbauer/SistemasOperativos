#!/bin/sh
# Flags without parameters
while getopts ":ab:" opt; do
  case $opt in
    a)
      echo "-a was triggered!" >&2
      ;;
    b)
      echo "-b was triggered, Parameter: $OPTARG" >&2
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done