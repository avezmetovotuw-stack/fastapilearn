#!/usr/bin/env bash
set -e

PROJECT_DIR="/home/ubuntu/fastapilearn"
DB_NAME="blog_db"
DB_USER="blog_user"

sudo apt update
sudo apt install -y python3-venv python3-pip nginx postgresql postgresql-contrib git

mkdir -p "$PROJECT_DIR"

if [ ! -f "$PROJECT_DIR/.env" ]; then
  echo "DATABASE_URL=postgresql://${DB_USER}:CHANGE_PASSWORD@127.0.0.1:5432/${DB_NAME}" > "$PROJECT_DIR/.env"
  echo "SECRET_KEY=change-this-secret-key" >> "$PROJECT_DIR/.env"
  echo "DEBUG=False" >> "$PROJECT_DIR/.env"
  echo "Created $PROJECT_DIR/.env. Edit DB password and SECRET_KEY before deploy."
fi

sudo cp "$PROJECT_DIR/deploy/fastapilearn.service" /etc/systemd/system/fastapilearn.service 2>/dev/null || true
sudo cp "$PROJECT_DIR/deploy/nginx_fastapilearn.conf" /etc/nginx/sites-available/fastapilearn 2>/dev/null || true
sudo ln -sf /etc/nginx/sites-available/fastapilearn /etc/nginx/sites-enabled/fastapilearn
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl daemon-reload
sudo systemctl enable fastapilearn
sudo systemctl enable nginx
sudo systemctl restart nginx

echo "Server base setup done. Now configure PostgreSQL user/db and GitHub Secrets."
