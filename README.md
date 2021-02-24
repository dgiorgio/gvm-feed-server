# gvm-feed-server
[https://github.com/dgiorgio/gvm-feed-server](https://github.com/dgiorgio/gvm-feed-server)
#### Run with docker-compose
```console
$ git clone https://github.com/dgiorgio/gvm-feed-server
$ cd gvm-feed-server
$ docker-compose up -d
```
By default, synchronization will start as soon as the container is started.

Cron is also applied by default, with the definition: 0 \*/1 \* \* \*

More details in the script [docker-entrypoint.sh](https://github.com/dgiorgio/gvm-feed-server/blob/master/build/docker-entrypoint.sh)

#### Build Dockerimage
```console
$ cd gvm-feed-server
$ ./build.sh
```

#### Docker compose customization
Crontab: Add 'CRON' var in the 'environment' var

Rsync: Add 'RSYNC_COMMAND' var in the 'environment' var

```console
---

version: '3'

services:
  app:
    image: "dgiorgio/gvm-feed-server:latest"
    hostname: "gvm-feed-server"
    restart: always
    ports:
      - "873:873"
    volumes:
      - "data:/data"
      - "/etc/localtime:/etc/localtime:ro"
    environment:
      - CRON=*/30 * * * *
      - RSYNC_COMMAND=rsync -ltrzP --delete --exclude private/ rsync://feed.community.greenbone.net:/${SERVER} /data/${SERVER}

volumes:
  data:

```

#### Test repository
Change "gvm_feed_server.service.com" to your server address.
```console
rsync --list-only rsync://gvm_feed_server.service.com:/
```

## License
This Docker image is licensed under the MIT, see [LICENSE](LICENSE.md).
