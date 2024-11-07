#!/bin/sh
cd /music
spotdl sync "$PLAYLIST_URL" --save-file /opt/sync.spotdl

tail -f /dev/null
