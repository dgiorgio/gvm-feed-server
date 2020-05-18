# gvm-nvt-feed-server
[https://github.com/dgiorgio/gvm-nvt-feed-server](https://github.com/dgiorgio/gvm-nvt-feed-server)
#### Run with docker-compose
```console
$ git clone https://github.com/dgiorgio/gvm-nvt-feed-server
$ cd gvm-nvt-feed-server
$ docker-compose up -d
```
By default, synchronization will start as soon as the container is started.
Cron is also applied by default, with the definition: 0 \*/1 \* \* \*
More details in the script [docker-entrypoint.sh](https://github.com/dgiorgio/gvm-nvt-feed-server/build/docker-entrypoint.sh)

#### Build Dockerimage
```console
$ cd gvm-nvt-feed-server
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
    image: "dgiorgio/gvm-nvt-feed-server:latest"
    hostname: "gvm-nvt-feed-server"
    restart: always
    ports:
      - "873:873"
    volumes:
      - "data:/data"
      - "/etc/localtime:/etc/localtime:ro"
    environment:
      - CRON=*/30 * * * *
      - RSYNC_COMMAND=rsync -ltrvP --delete --exclude private/ rsync://feed.community.greenbone.net:/nvt-feed /data/nvt_feed

volumes:
  data:

```

## License
This Docker image is licensed under the MIT, see [LICENSE](LICENSE.md).
