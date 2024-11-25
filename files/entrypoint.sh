#!/bin/sh

# Read playlist URLs from environment variable
IFS=',' read -r -a PLAYLIST_URLS <<< "$PLAYLIST_URLS"

# Sync each playlist
for PLAYLIST_URL in "${PLAYLIST_URLS[@]}"; do
  if [ "$ENABLE_LOGS" = "true" ]; then
    spotdl sync "$PLAYLIST_URL" --save-file /opt/sync.spotdl --log-file /logs/spotdl.log
  else
    spotdl sync "$PLAYLIST_URL" --save-file /opt/sync.spotdl
  fi
done

# Keep the container running
tail -f /dev/null 