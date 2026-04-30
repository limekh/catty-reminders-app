# ~/DevOps/catty-reminders-app/deploy.sh
#!/usr/bin/env bash
set -euo pipefail

APP_DIR="/home/anm/DevOps/catty-reminders-app"
ENV_FILE="$APP_DIR/.env.deploy"

echo "🚀 Deploying Catty..."

cd "$APP_DIR"

if [ ! -d .venv ]; then
    python3 -m venv .venv
fi

.venv/bin/pip install -r requirements.txt -q

DEPLOY_REF="$(git rev-parse HEAD)"
echo "📝 Setting DEPLOY_REF=$DEPLOY_REF"
printf 'DEPLOY_REF=%s\n' "$DEPLOY_REF" > "$ENV_FILE"

echo "🔄 Restarting catty-app.service..."
sudo systemctl restart catty-app.service

sleep 5

if sudo systemctl is-active --quiet catty-app.service; then
    echo "✅ Catty deployed successfully (ref: $DEPLOY_REF)"
else
    echo "❌ Catty service failed to start!"
    sudo journalctl -u catty-app -n 10 --no-pager
    exit 1
fi
