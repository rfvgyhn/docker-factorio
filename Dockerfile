FROM frolvlad/alpine-glibc:alpine-3.4

MAINTAINER rfvgyhn

RUN apk --no-cache add tini
ENTRYPOINT ["/sbin/tini", "--"]

ENV VERSION=0.14.12
RUN apk --no-cache add curl pwgen && \
    mkdir -p /opt /saves && \
    curl -LSs https://www.factorio.com/get-download/${VERSION}/headless/linux64 | tar -xzC /opt && \
    ln -s /saves /opt/factorio/saves && \
    apk --no-cache del curl

COPY files /
RUN chmod +x /usr/local/bin/factorio

VOLUME /saves
VOLUME /mods
VOLUME /config

# RCON
EXPOSE 27015/udp

# Game
EXPOSE 34197/udp

ENV FACTORIO_SAVE_NAME=meeseeks

CMD ["/run.sh"]