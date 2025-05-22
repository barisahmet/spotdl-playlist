FROM alpine:3.17

# Install dependencies and spotdl
RUN apk add --no-cache python3 pipx && \
    pipx install --global spotdl && \
    spotdl --download-ffmpeg && \
    mkdir /music /logs

# Copy necessary scripts
COPY files/update_spotdl.sh /etc/periodic/daily/
COPY files/entrypoint.sh /opt/

# Set permissions after copying
RUN chmod +x /opt/entrypoint.sh /etc/periodic/daily/update_spotdl.sh

# Set working directory
WORKDIR /music

# Expose volumes for music and logs
VOLUME ["/music", "/logs"]

# Use a non-root user
RUN adduser -D -u 1000 appuser
USER appuser

# Set entrypoint
CMD ["/opt/entrypoint.sh"]

LABEL maintainer="barisahmet <barisahmet@gmail.com>"
