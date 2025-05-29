# gvm-feed-server
[https://github.com/dgiorgio/gvm-feed-server](https://github.com/dgiorgio/gvm-feed-server)

The `gvm-feed-server` is a Docker server that replicates the official Greenbone Vulnerability Manager (GVM) feeds to create a local mirror.

#### Run with docker compose
```console
$ git clone https://github.com/dgiorgio/gvm-feed-server
$ cd gvm-feed-server
$ docker compose up -d
```
By default, synchronization will start as soon as the container starts. A cron job is also set up to run automatically with the default schedule: `0 */1 * * *`

For more details on startup and synchronization scripts, see [docker-entrypoint.sh](https://github.com/dgiorgio/gvm-feed-server/blob/master/build/docker-entrypoint.sh)

#### Building the Docker Image
```console
$ cd gvm-feed-server
$ ./build.sh
```

#### Docker Compose Customization
##### Environment Variables
You can customize the synchronization and cron frequency using environment variables:

**CRON**: Set the cron frequency to automate synchronization (example: */30 * * * * to run every 30 minutes).
**RSYNC_COMMAND**: Set the rsync command to customize the synchronization process (e.g., exclude specific folders).

##### Example of docker-compose.yml with Customization
```console
---

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
To test the rsync server, replace `gvm_feed_server.service.com` with your server’s address:
```console
rsync --list-only rsync://gvm_feed_server.service.com:/
```

## License
This Docker image is licensed under the MIT, see [LICENSE](LICENSE.md).
