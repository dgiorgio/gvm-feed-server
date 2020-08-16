#!/usr/bin/env sh

SERVER="${1}"
DATE="$(date '+%Y-%m-%d %H:%M:%S')"
RSYNC_COMMAND="rsync -ltrzP --delete --exclude private/ rsync://feed.community.greenbone.net:/${SERVER} /data/${SERVER}"

rm -f /var/run/rsyncd.pid
${RSYNC_COMMAND} >> /var/log/${SERVER}.log 2>&1

if [ "${?}" == "0" ]; then
  STATUS="Sync '${SERVER}' completed!"
else
  STATUS="Sync '${SERVER}' failed!"
fi

echo "${DATE} - ${STATUS}" >> /var/log/${SERVER}.log 2>&1
