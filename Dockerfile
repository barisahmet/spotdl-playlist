FROM alpine:latest

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETARCH
ARG TARGETVARIANT
RUN printf '..%s..' "I'm building for TARGETPLATFORM=${TARGETPLATFORM} using BUILDPLATFORM=${BUILDPLATFORM} as build platform" \
    && printf '..%s..' ", TARGETARCH=${TARGETARCH}" \
    && printf '..%s..' ", TARGETVARIANT=${TARGETVARIANT} \n" \
    && printf '..%s..' "With uname -s : " && uname -s \
    && printf '..%s..' "and  uname -m : " && uname -m

RUN apk add --no-cache python3 pipx
RUN pipx install --global spotdl
RUN spotdl --download-ffmpeg

WORKDIR /tmp

COPY files/entrypoint.sh /etc/periodic/hourly/spotdl.sh
COPY files/entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /etc/periodic/hourly/spotdl.sh
RUN chmod +x /opt/entrypoint.sh
RUN mkdir /music

VOLUME ["/music"]

CMD ["/opt/entrypoint.sh"]

LABEL maintainer="barisahmet<barisahmet@gmail.com> "