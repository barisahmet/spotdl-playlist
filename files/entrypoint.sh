#!/bin/sh

# Default sync interval to hourly if not set
SYNC_INTERVAL=${SYNC_INTERVAL:-hourly}

# Read playlist URLs from environment variable
PLAYLIST_URLS=$(echo "$PLAYLIST_URLS" | tr ',' ' ')

# Mapping file to store playlist URLs and their corresponding directory names
MAPPING_FILE="/opt/playlist_mapping.txt"

# Function to sanitize playlist names
sanitize_name() {
  echo "$1" | tr ' ' '_' | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9_-]//g'
}

# Function to get or create a directory name for a playlist URL
get_playlist_dir() {
  PLAYLIST_URL=$1
  # Check if the playlist URL is already in the mapping file
  if grep -q "$PLAYLIST_URL" "$MAPPING_FILE"; then
    # Get the old directory name from the mapping file
    OLD_PLAYLIST_DIR=$(grep "$PLAYLIST_URL" "$MAPPING_FILE" | cut -d ' ' -f 2)
    # Get the current playlist name
    CURRENT_PLAYLIST_NAME=$(spotdl list "$PLAYLIST_URL" | head -n 1 | tr -d '[:space:]')
    # Sanitize the playlist name
    SANITIZED_PLAYLIST_NAME=$(sanitize_name "$CURRENT_PLAYLIST_NAME")
    # Create the new directory name
    NEW_PLAYLIST_DIR="/music/$SANITIZED_PLAYLIST_NAME"
    # If the old directory name is different from the new one, rename the directory
    if [ "$OLD_PLAYLIST_DIR" != "$NEW_PLAYLIST_DIR" ]; then
      mv "$OLD_PLAYLIST_DIR" "$NEW_PLAYLIST_DIR"
      # Update the mapping file with the new directory name
      sed -i "s|$OLD_PLAYLIST_DIR|$NEW_PLAYLIST_DIR|g" "$MAPPING_FILE"
    fi
    echo "$NEW_PLAYLIST_DIR"
  else
    # Get the current playlist name
    CURRENT_PLAYLIST_NAME=$(spotdl list "$PLAYLIST_URL" | head -n 1 | tr -d '[:space:]')
    # Sanitize the playlist name
    SANITIZED_PLAYLIST_NAME=$(sanitize_name "$CURRENT_PLAYLIST_NAME")
    # Create a unique directory name
    NEW_PLAYLIST_DIR="/music/$SANITIZED_PLAYLIST_NAME"
    # Save the mapping
    echo "$PLAYLIST_URL $NEW_PLAYLIST_DIR" >> "$MAPPING_FILE"
    echo "$NEW_PLAYLIST_DIR"
  fi
}

sync_playlists() {
  # Sync each playlist
  for PLAYLIST_URL in $PLAYLIST_URLS; do
    # Get or create the directory for the playlist
    PLAYLIST_DIR=$(get_playlist_dir "$PLAYLIST_URL")
    mkdir -p "$PLAYLIST_DIR"
    
    # Sync the playlist
    if [ "$ENABLE_LOGS" = "true" ]; then
      spotdl sync "$PLAYLIST_URL" --save-file /opt/sync.spotdl --log-file /logs/spotdl.log --output "$PLAYLIST_DIR"
    else
      spotdl sync "$PLAYLIST_URL" --save-file /opt/sync.spotdl --output "$PLAYLIST_DIR"
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