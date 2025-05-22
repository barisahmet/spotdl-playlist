# spotdl-playlist
Uses [spotdl](https://github.com/spotDL/spotify-downloader) python library for downloading a Spotify playlist to a specified folder and keeping it up to date. I personally use it in my Home Assistant setup to play tracks locally on my Sonos devices, since Wi-Fi connections can sometimes be unreliable.

> [!NOTE]
> It automatically handles spotdl library updates. No update necessary.

Example `docker-compose.yml`:
```
version: "3"
services:
  spotdl:
    container_name: spotdl
    restart: unless-stopped
    image: ghcr.io/barisahmet/spotdl-playlist:latest
    volumes:
      - /path/to/folder:/music
      - /path/to/logs:/logs
    environment:
      PLAYLIST_URLS: "https://[spotify playlist url here],https://[another spotify playlist url here]"
      ENABLE_LOGS: "true"
      SYNC_INTERVAL: "daily"
```
## Environment Variables

- `PLAYLIST_URLS`: Comma-separated list of Spotify playlist URLs to sync.
- `SYNC_INTERVAL`: Interval for syncing playlists (e.g., `hourly`, `daily`).
- `ENABLE_LOGS`: Set to `true` to enable logging, `false` to disable logging.

## Volumes

- `/music`: Directory to store downloaded music.
- `/logs`: Directory to store log files. 
