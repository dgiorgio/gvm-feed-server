FROM alpine:3.16.1

RUN apk add --no-cache rsync tini
COPY rsyncd.conf /etc/rsyncd.conf

COPY docker-entrypoint.sh sync.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/docker-entrypoint.sh"]
CMD ["rsync", "--daemon", "--no-detach", "--verbose"]

VOLUME ["/data"]
EXPOSE 873
