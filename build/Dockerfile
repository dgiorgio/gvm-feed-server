FROM alpine:3.11.6

RUN apk add --no-cache rsync
COPY rsyncd.conf /etc/rsyncd.conf

COPY docker-entrypoint.sh sync-nvt.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["rsync", "--daemon", "--no-detach", "--verbose"]

VOLUME ["/data"]
EXPOSE 873
