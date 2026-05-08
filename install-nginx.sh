#!/bin/bash
# install-nginx.sh - установка и настройка nginx

set -e

echo "Installing nginx..."
sudo apt update
sudo apt install -y nginx

echo "Setting up nginx configuration..."
# Создаем директорию если нет
sudo mkdir -p /etc/nginx/sites-available
sudo mkdir -p /etc/nginx/sites-enabled

# Удаляем дефолтный конфиг если есть
sudo rm -f /etc/nginx/sites-enabled/default

echo "Nginx installed. Next step: configure with nginx.conf"
echo "Copy your nginx.conf to /etc/nginx/sites-available/catty-reminders"
echo "Then: sudo ln -s /etc/nginx/sites-available/catty-reminders /etc/nginx/sites-enabled/"
echo "Then: sudo nginx -t && sudo systemctl restart nginx"
