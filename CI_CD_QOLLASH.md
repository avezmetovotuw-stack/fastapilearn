# FastAPI loyihani GitHub CI/CD qilish

## 1) GitHub Secrets
Repository → Settings → Secrets and variables → Actions → New repository secret:

- `SSH_HOST` = server IP, masalan `44.xxx.xxx.xxx`
- `SSH_USER` = `ubuntu`
- `SSH_KEY` = Macdagi private key matni: `cat ~/.ssh/id_ed25519`
- `PROJECT_DIR` = `/home/ubuntu/fastapilearn`
- `DATABASE_URL` = `postgresql://blog_user:PAROL@127.0.0.1:5432/blog_db`
- `SECRET_KEY` = uzun maxfiy kalit

## 2) Serverda birinchi marta bajariladigan komandalar
```bash
sudo apt update
sudo apt install -y python3-venv python3-pip nginx postgresql postgresql-contrib git
mkdir -p /home/ubuntu/fastapilearn
```

PostgreSQL:
```bash
sudo -u postgres psql
CREATE DATABASE blog_db;
CREATE USER blog_user WITH PASSWORD 'KUCHLI_PAROL';
GRANT ALL PRIVILEGES ON DATABASE blog_db TO blog_user;
ALTER DATABASE blog_db OWNER TO blog_user;
\q
```

## 3) Macdan GitHubga push
```bash
git add .
git commit -m "Add CI/CD deploy"
git push origin main
```

Shundan keyin har safar `main` branchga push qilsangiz GitHub Actions serverga kodni yuboradi, `pip install` qiladi va `fastapilearn` servisni restart qiladi.

## 4) Tekshirish
```bash
sudo systemctl status fastapilearn
sudo journalctl -u fastapilearn -f
curl http://127.0.0.1:8000/health
```

Browserda:

- `http://SERVER_IP/`
- `http://SERVER_IP/docs`
- `http://SERVER_IP/health`
