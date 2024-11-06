#!/bin/sh
playlist_url=`cat config.txt`
cd /music
spotdl "$playlist_url"