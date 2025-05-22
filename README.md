# spotdl-playlist
Uses [spotdl](https://github.com/spotDL/spotify-downloader) python library to download a Spotify playlist to a designated folder and automatically keeps it synchronized. I employ it within my Home Assistant environment to enable uninterrupted local playback on Sonos devices during internet outages (yes, internet outages is still a thing in Turkey in 2025).

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
