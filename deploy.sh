#!/usr/bin/env bash
set -euo pipefail

APP_NAME="catty-app"
IMAGE="ghcr.io/limekh/catty-reminders-app:latest"

echo "🚀 Deploying Catty via Docker..."

echo "Pull image"
docker pull $IMAGE

echo "STOP old container"
docker stop $APP_NAME || true
docker rm $APP_NAME || true

echo "RUN new container"
docker run -d \
  --name $APP_NAME \
  -p 8181:8181 \
  -e DEPLOY_REF=(git rev-parse HEAD) \
  $IMAGE

echo "Deploy done"
