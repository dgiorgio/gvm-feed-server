#!/usr/bin/env sh

DATE="$(date '+%Y-%m-%d %H:%M:%S')"
RSYNC_COMMAND="rsync -ltrzP --delete --exclude private/ rsync://feed.community.greenbone.net:/nvt-feed /data/nvt_feed"

${RSYNC_COMMAND} >> /var/log/nvt-sync.log 2>&1

if [ "${?}" == "0" ]; then
  STATUS="Sync completed!"
else
  STATUS="Sync failed!"
fi

echo "${DATE} - ${STATUS}"
