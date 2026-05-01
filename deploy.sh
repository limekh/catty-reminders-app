#!/usr/bin/env bash
set -euo pipefail

APP_NAME="catty-app"
IMAGE="ghcr.io/limekh/catty-reminders-app:latest"

echo "🚀 Deploying Catty via Docker..."

cd /home/anm/DevOps/catty-reminders-app

echo "Pull image"
docker pull $IMAGE

echo "Stop all containers using port 8181"
docker ps --filter "publish=8181" -q | xargs -r docker stop
docker ps -a --filter "publish=8181" -q | xargs -r docker rm

echo "Remove old container"
docker stop $APP_NAME || true
docker rm $APP_NAME || true

DEPLOY_REF=$(git rev-parse HEAD)
echo "DEPLOY_REF=$DEPLOY_REF"

echo "RUN new container"
docker run -d \
  --name $APP_NAME \
  -p 8181:8181 \
  -e DEPLOY_REF=$DEPLOY_REF \
  $IMAGE

echo "Deploy done"
