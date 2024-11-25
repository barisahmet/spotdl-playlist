#!/bin/sh

# Check if the log file exists and is not empty
if [ -s /logs/spotdl.log ]; then
  exit 0
else
  exit 1
fi 