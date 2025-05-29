#!/usr/bin/env sh

_start() {
  local DATE STATUS RSYNC_COMMAND

  DATE="$(date '+%Y-%m-%d %H:%M:%S')"
  touch "/var/log/${1}.log"
  echo "Starting ${1} synchronization..."

  # Define o comando de sincronização para este servidor específico
  RSYNC_COMMAND="rsync -ltvr --info=progress2 --delete --exclude private/ rsync://feed.community.greenbone.net:/${1} /data/${1}"
  ${RSYNC_COMMAND} >> "/var/log/${1}.log" 2>&1

  # Verifica o status de saída e registra o resultado
  if [ "${?}" -eq 0 ]; then
    STATUS="Sync '${1}' completed!"
  else
    STATUS="Sync '${1}' failed!"
  fi

  echo "${DATE} - ${STATUS}" | tee -a "/var/log/${1}.log"
  sleep 10 # waiting rsync disconnect
}

# Executa a sincronização para cada servidor
for i in ${SERVERS}; do
  _start "${i}"
done
