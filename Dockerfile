FROM alpine:latest

RUN apk add --no-cache python3 pipx
RUN pipx install --global spotdl
RUN spotdl --download-ffmpeg

COPY files/spotdl.sh /etc/periodic/hourly/
COPY files/update_spotdl.sh /etc/periodic/daily/
COPY files/entrypoint.sh /opt/
COPY files/healthcheck.sh /opt/

RUN chmod +x /opt/entrypoint.sh
RUN chmod +x /etc/periodic/daily/update_spotdl.sh
RUN chmod +x /opt/healthcheck.sh
RUN mkdir /music
RUN mkdir /logs

WORKDIR /music

VOLUME ["/music", "/logs"]

HEALTHCHECK CMD /opt/healthcheck.sh

CMD ["/opt/entrypoint.sh"]

LABEL maintainer="barisahmet <barisahmet@gmail.com>" 
