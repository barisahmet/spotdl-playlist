#!/bin/sh

# Default sync interval to hourly if not set
SYNC_INTERVAL=${SYNC_INTERVAL:-hourly}

# Read playlist URLs from environment variable
IFS=',' read -r -a PLAYLIST_URLS <<< "$PLAYLIST_URLS"

sync_playlists() {
  # Sync each playlist
  for PLAYLIST_URL in "${PLAYLIST_URLS[@]}"; do
    if [ "$ENABLE_LOGS" = "true" ]; then
      spotdl sync "$PLAYLIST_URL" --save-file /opt/sync.spotdl --log-file /logs/spotdl.log
    else
      spotdl sync "$PLAYLIST_URL" --save-file /opt/sync.spotdl
    fi
  done
}

# Initial sync
sync_playlists

# Periodically sync based on SYNC_INTERVAL
while true; do
  case "$SYNC_INTERVAL" in
    hourly)
      sleep 3600
      ;;
    daily)
      sleep 86400
      ;;
    *)
      echo "Invalid SYNC_INTERVAL: $SYNC_INTERVAL. Defaulting to hourly."
      sleep 3600
      ;;
  esac
  sync_playlists
done