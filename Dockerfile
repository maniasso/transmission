FROM alpine as builder

COPY configure.sh /usr/local/bin/configure
COPY daemon.sh /usr/bin/my-daemon
FROM builder

LABEL maintainer="Created by Jay MOULIN and update by Robson Maniasso"
ARG VERSION=4.0.4
LABEL version=${VERSION}

RUN echo "http://dl-4.alpinelinux.org/alpine/latest-stable/main/" >> /etc/apk/repositories && \
apk update && apk upgrade && \
apk add transmission-daemon wget curl --no-cache && \
wget "https://raw.githubusercontent.com/ronggang/transmission-web-control/master/release/install-tr-control.sh" -O /tmp/install.sh && \
(echo 1 | sh /tmp/install.sh) && \
rm /tmp/install.sh && \
mkdir /download && \
mkdir /download/incomplete && \
mkdir /config &&\
chmod 777 /download && \
chmod 777 /download/incomplete && \
chmod 777 /config && \
apk del wget curl --purge && \
chmod 755 /usr/bin/my-daemon
WORKDIR /usr/bin

COPY settings.json /config/settings.json

EXPOSE 9091
EXPOSE 51413
EXPOSE 51413/udp

VOLUME /download
VOLUME /config
VOLUME /download/incomplete

ENV PORT=9091

CMD my-daemon
