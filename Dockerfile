FROM rtorrent:latest

ENV UID=496 GID=500 \
    FLOOD_SECRET=bleh-bli-blou \
    WEBROOT=/ \
    RTORRENT_SCGI=0 \
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

ARG FLOOD_VER=master
RUN mkdir /usr/flood && cd /usr/flood && wget -qO- https://github.com/gboudreau/flood/archive/${FLOOD_VER}.tar.gz | tar xz --strip 1 \
 && npm install && npm cache clean --force \
 && apk del build-dependencies \
 && rm -rf /var/cache/apk/* /tmp/*

COPY rootfs /

RUN chmod +x /usr/local/bin/* /etc/s6.d/*/* /etc/s6.d/.s6-svscan/* \
 && cd /usr/flood/ && npm run build

VOLUME /data /flood-db /home/torrent

EXPOSE 3000 16842 16842/udp 4200

LABEL description="rTorrent BitTorrent server with Flood front-end" \
      maintainer="Guillaume Boudreau <guillaume@pommepause.com>"

CMD ["run.sh"]
