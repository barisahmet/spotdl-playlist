# SpotDL
Uses spotdl Python library to download and update (hourly) a spotify playlist into specified folder. Personally use it for my Home Assistant setup to play tracks locally with my Sonos devices.

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
