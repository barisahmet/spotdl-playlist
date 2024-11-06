#!/bin/sh
echo $PLAYLIST_URL > /opt/playlist-url
cd /music
spotdl "$PLAYLIST_URL"