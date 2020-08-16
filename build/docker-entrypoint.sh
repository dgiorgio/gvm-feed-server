#!/usr/bin/env sh

SERVERS="data-objects nvt-feed scap-data cert-data"
CRON_FILE="/etc/cron.d/crontab"
mkdir -p "/etc/cron.d"

# Create cron
[ "${CRON}" == "" ] && CRON="0 */1 * * *"
touch "${CRON_FILE}" && \
chmod 0644 "${CRON_FILE}"
for i in ${SERVERS} ; do
  echo "${CRON} /usr/local/bin/sync.sh ${i} >> /var/log/${i}.log 2>&1" >> "${CRON_FILE}"
done
crontab "${CRON_FILE}"
# Start cron
crond

# Start rsync
for i in ${SERVERS} ; do
  echo "Starting ${i} synchronization..."
  touch /var/log/${i}.log
  /usr/local/bin/sync.sh ${i} >> /var/log/${i}.log 2>&1 &
done

rm -f /var/run/rsyncd.pid
tail -f /var/log/*.log &
echo "Starting rsync server..."
exec "$@"
