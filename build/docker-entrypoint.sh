#!/usr/bin/env sh

SERVERS="data-objects nvt-feed scap-data cert-data"
CRON_FILE="/etc/cron.d/crontab"
mkdir -p "/etc/cron.d"

# Create cron
[ "${CRON}" == "" ] && CRON="0 */1 * * *"
touch "${CRON_FILE}" && \
chmod 0644 "${CRON_FILE}"
echo "${CRON} export SERVERS=\"${SERVERS}\" ; /usr/local/bin/sync.sh" > "${CRON_FILE}"
crontab "${CRON_FILE}"
# Start cron
crond

for i in ${SERVERS}; do
  touch /var/log/${i}.log
done

tail -f /var/log/*.log &
rm -f /var/run/rsyncd.pid
# Start rsync
SERVERS="${SERVERS}" /usr/local/bin/sync.sh
echo "Starting rsync server..."
exec "$@"
