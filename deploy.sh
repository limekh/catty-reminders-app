#!/usr/bin/env bash
set -euo pipefail

IMAGE="ghcr.io/limekh/catty-reminders-app:latest"

echo "🚀 Deploying Catty via Docker compose..."

cd /home/anm/DevOps/catty-reminders-app

echo "Pull image"
docker pull $IMAGE

echo "Stop old containers"
docker compose down || true

echo "Start new containers"
docker compose up -d

echo "Deploy done"
