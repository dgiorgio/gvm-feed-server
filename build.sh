#!/usr/bin/env bash

set -e

cd ./build

# default - vars
[ -z "${BUILD}" ] && BUILD=""

# build gvm-nvt-feed-server
echo "
################################################################################
################### Build gvm-nvt-feed-server ##############################################
################################################################################"
gvm_nvt_feed_server_version=1.0
build_gvm_nvt_feed_server=""
docker build -f ./Dockerfile \
  -t "dgiorgio/gvm-nvt-feed-server:${gvm_nvt_feed_server_version}${build_gvm_nvt_feed_server:-${BUILD}}" \
  -t "dgiorgio/gvm-nvt-feed-server:latest" .

# push
if [ "${1}" == "push" ]; then
  docker push "dgiorgio/gvm-nvt-feed-server:${gvm_nvt_feed_server_version}${build_gvm_nvt_feed_server:-${BUILD}}"
  docker push "dgiorgio/gvm-nvt-feed-server:latest"
fi
