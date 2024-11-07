FROM alpine:3.14

COPY files/spotdl.sh /etc/periodic/hourly/
COPY files/update_spotdl.sh /etc/periodic/daily/
COPY files/entrypoint.sh /opt/

RUN apk add --no-cache python3 pipx && \
    pipx install --global spotdl && \
    spotdl --download-ffmpeg

RUN chmod +x /etc/periodic/hourly/spotdl.sh /opt/entrypoint.sh /etc/periodic/daily/update_spotdl.sh && \
    mkdir /music

WORKDIR /music

VOLUME ["/music"]

CMD ["/opt/entrypoint.sh"]

LABEL maintainer="barisahmet <barisahmet@gmail.com>"
