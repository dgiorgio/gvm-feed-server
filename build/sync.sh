#!/usr/bin/env sh

_start() {
  touch /var/log/${1}.log
  echo "Starting ${1} synchronization..."
  ${RSYNC_COMMAND} >> /var/log/${1}.log 2>&1

  if [ "${?}" == "0" ]; then
    STATUS="Sync '${1}' completed!"
  else
    STATUS="Sync '${1}' failed!"
  fi

  echo "${DATE} - ${STATUS}" >> /var/log/${1}.log 2>&1
  echo "${DATE} - ${STATUS}"
  sleep 10 # waiting rsync disconnect
}

for i in ${SERVERS}; do
  DATE="$(date '+%Y-%m-%d %H:%M:%S')"
  RSYNC_COMMAND="rsync -ltrzPv --delete --exclude private/ rsync://feed.community.greenbone.net:/${i} /data/${i}"
  _start ${i}
done
