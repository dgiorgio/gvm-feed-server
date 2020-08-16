#!/usr/bin/env bash

set -e

cd ./build

# default - vars
[ -z "${BUILD}" ] && BUILD=""

# build gvm-feed-server
echo "
################################################################################
################### Build gvm-feed-server ##############################################
################################################################################"
gvm_feed_server_version=2.0
build_gvm_feed_server=""
docker build -f ./Dockerfile \
  -t "dgiorgio/gvm-feed-server:${gvm_feed_server_version}${build_gvm_feed_server:-${BUILD}}" \
  -t "dgiorgio/gvm-feed-server:latest" .

# push
if [ "${1}" == "push" ]; then
  docker push "dgiorgio/gvm-feed-server:${gvm_feed_server_version}${build_gvm_feed_server:-${BUILD}}"
  docker push "dgiorgio/gvm-feed-server:latest"
fi
