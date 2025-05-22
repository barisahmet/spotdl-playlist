FROM alpine:latest

RUN apk add --no-cache python3 pipx
RUN pipx install --global spotdl
RUN spotdl --download-ffmpeg

COPY files/update_spotdl.sh /etc/periodic/daily/
COPY files/entrypoint.sh /opt/

RUN chmod +x /opt/entrypoint.sh
RUN chmod +x /etc/periodic/daily/update_spotdl.sh

RUN mkdir /music
RUN mkdir /logs

WORKDIR /music

VOLUME ["/music", "/logs"]

CMD ["/opt/entrypoint.sh"]

LABEL maintainer="barisahmet <barisahmet@gmail.com>" 
