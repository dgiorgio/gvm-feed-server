#!/usr/bin/env bash

set -e

# Caminho da pasta de build e versão do servidor
BUILD_DIR="./build"
GVM_FEED_SERVER_VERSION="2.4"
BUILD_GVM_FEED_SERVER="-20250529"
IMAGE_NAME="dgiorgio/gvm-feed-server"

# Define o caminho da build
cd "${BUILD_DIR}"

# Exibe informações da build
echo "
################################################################################
################### Building gvm-feed-server ###################################
################################################################################
Image: ${REGISTRY}${IMAGE_NAME}:${GVM_FEED_SERVER_VERSION}${BUILD_GVM_FEED_SERVER}"

# Build da imagem Docker com várias tags
docker build -f ./Dockerfile \
  -t "${IMAGE_NAME}:${GVM_FEED_SERVER_VERSION}${BUILD_GVM_FEED_SERVER}" \
  -t "${IMAGE_NAME}:${GVM_FEED_SERVER_VERSION}" \
  -t "${IMAGE_NAME}:latest" .

# Push das imagens caso o argumento "push" seja fornecido
if [ "$1" = "push" ]; then
  echo "Pushing images to ${REGISTRY}..."
  docker push "${IMAGE_NAME}:${GVM_FEED_SERVER_VERSION}${BUILD_GVM_FEED_SERVER}"
  docker push "${IMAGE_NAME}:${GVM_FEED_SERVER_VERSION}"
  docker push "${IMAGE_NAME}:latest"
  echo "Push completed."
else
  echo "Build completed. Skipping push."
fi
