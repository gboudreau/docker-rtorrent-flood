FROM alpine:3.11

ENV PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

ARG BUILD_CORES=4
RUN NB_CORES=${BUILD_CORES-`getconf _NPROCESSORS_CONF`} \
 && apk -U upgrade \
 && apk add -t build-dependencies --no-cache \
    build-base \
    git \
    libtool \
    automake \
    autoconf \
    wget \
    tar \
    xz \
    zlib-dev \
    cppunit-dev \
    openssl-dev \
    ncurses-dev \
    curl-dev \
    binutils \
    linux-headers \
 && apk add --no-cache \
    ca-certificates \
    curl \
    ncurses \
    openssl \
    gzip \
    zip \
    zlib \
    s6 \
    su-exec \
    python \
    nodejs \
    nodejs-npm \
    unrar \
    findutils \
    mediainfo

ARG RTORRENT_VER=0.9.8
ARG LIBTORRENT_VER=0.13.8
RUN cd /tmp && mkdir libtorrent rtorrent \
 && cd libtorrent && wget -qO- https://github.com/rakshasa/libtorrent/archive/v${LIBTORRENT_VER}.tar.gz | tar xz --strip 1 \
 && cd ../rtorrent && wget -qO- https://github.com/rakshasa/rtorrent/releases/download/v${RTORRENT_VER}/rtorrent-${RTORRENT_VER}.tar.gz | tar xz --strip 1 \
 && cd /tmp \
 && git clone https://github.com/mirror/xmlrpc-c.git \
 && cd /tmp/xmlrpc-c/advanced && ./configure && make -j ${NB_CORES} && make install \
 && cd /tmp/libtorrent && ./autogen.sh && ./configure && make -j ${NB_CORES} && make install \
 && cd /tmp/rtorrent && ./autogen.sh && ./configure --with-xmlrpc-c && make -j ${NB_CORES} && make install \
 && cd /tmp \
 && rm -r xmlrpc-c libtorrent rtorrent

LABEL description="rTorrent BitTorrent server" \
      rtorrent="rTorrent v$RTORRENT_VER" \
      libtorrent="libtorrent v$LIBTORRENT_VER" \
      maintainer="Guillaume Boudreau <guillaume@pommepause.com>"
