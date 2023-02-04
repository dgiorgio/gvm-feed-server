#!/usr/bin/env bash

set -e

cd ./build

# build gvm-feed-server
gvm_feed_server_version=2.3
build_gvm_feed_server="-20230203"
echo "
################################################################################
################### Build gvm-feed-server ######################################
################################################################################
Image: ${REGISTRY}dgiorgio/gvm-feed-server:${gvm_feed_server_version}${build_gvm_feed_server}"

docker build -f ./Dockerfile \
  -t "dgiorgio/gvm-feed-server:${gvm_feed_server_version}${build_gvm_feed_server}" \
  -t "dgiorgio/gvm-feed-server:${gvm_feed_server_version}" \
  -t "dgiorgio/gvm-feed-server:latest" .

# push
if [ "${1}" == "push" ]; then
  docker push "dgiorgio/gvm-feed-server:${gvm_feed_server_version}${build_gvm_feed_server}"
  docker push "dgiorgio/gvm-feed-server:${gvm_feed_server_version}"
  docker push "dgiorgio/gvm-feed-server:latest"
fi
