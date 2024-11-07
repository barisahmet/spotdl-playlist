FROM alpine:latest

RUN apk add --no-cache python3 pipx
RUN pipx install --global spotdl
RUN spotdl --download-ffmpeg

COPY files/spotdl.sh /etc/periodic/hourly/
COPY files/update_spotdl.sh /etc/periodic/daily/
COPY files/entrypoint.sh /opt/

RUN chmod +x /etc/periodic/hourly/spotdl.sh
RUN chmod +x /opt/entrypoint.sh
RUN chmod +x /etc/periodic/daily/update_spotdl.sh
RUN mkdir /music

WORKDIR /music

VOLUME ["/music"]

CMD ["/opt/entrypoint.sh"]

LABEL maintainer="barisahmet <barisahmet@gmail.com> "
