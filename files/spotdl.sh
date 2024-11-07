#!/bin/sh
playlist_url=`cat /opt/playlist-url`
cd /music
spotdl "$playlist_url"
