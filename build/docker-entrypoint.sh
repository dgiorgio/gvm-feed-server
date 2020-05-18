#!/usr/bin/env sh

CRON_FILE="/etc/cron.d/crontab"
mkdir -p "/etc/cron.d"
touch /var/log/nvt-sync-status.log

# Create cron
[ "${CRON}" == "" ] && CRON="0 */1 * * *"
touch "${CRON_FILE}" && \
chmod 0644 "${CRON_FILE}"
echo "${CRON} /usr/local/bin/sync-nvt.sh >> /var/log/nvt-sync-status.log 2>&1" >> "${CRON_FILE}"
crontab "${CRON_FILE}"
# Start cron
crond

# Start rsync
echo "Starting NVT synchronization..."
/usr/local/bin/sync-nvt.sh >> /var/log/nvt-sync-status.log 2>&1 &

tail -f /var/log/nvt-sync-status.log &
echo "Starting rsync server..."
exec "$@"
