# spotdl-playlist
Uses [spotdl](https://github.com/spotDL/spotify-downloader) Python library to download a spotify playlist into specified folder and keeps it up-to-date. Personally, I use it for my Home Assistant setup to play tracks locally with my Sonos devices.

> [!NOTE]
> It automatically handles spotdl library updates. No update necessary.

Example:
```
spotdl:
  container_name: spotdl
  restart: unless-stopped
  image: ghcr.io/barisahmet/spotdl-playlist:latest
  volumes:
    - /path/to/downloads:/music
  environment:
    - PLAYLIST_URL: "https://[spotify playlist url here]"
```
