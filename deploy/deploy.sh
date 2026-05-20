#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="/home/ubuntu/fastapilearn"
cd "$PROJECT_DIR"

python3 -m venv venv
source venv/bin/activate
python -m pip install --upgrade pip
pip install -r requirements.txt

sudo cp deploy/fastapilearn.service /etc/systemd/system/fastapilearn.service
sudo cp deploy/nginx_fastapilearn.conf /etc/nginx/sites-available/fastapilearn
sudo ln -sf /etc/nginx/sites-available/fastapilearn /etc/nginx/sites-enabled/fastapilearn
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl daemon-reload
sudo systemctl enable fastapilearn
sudo systemctl restart fastapilearn
sudo systemctl restart nginx
sudo systemctl --no-pager --full status fastapilearn | head -40
