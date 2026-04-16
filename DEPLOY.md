# 🚀 Guide de déploiement sur serveur

## Option 1 : Déploiement avec Docker (recommandé)

### Prérequis
- Docker et Docker Compose installés sur votre serveur
- Une clé OpenAI API
- Un domaine (optionnel)

### Étapes

#### 1. Cloner le projet
```bash
git clone https://github.com/diouck/openmapagents.git
cd openmapagents
```

#### 2. Configurer les variables d'environnement
```bash
cp .env.example .env
nano .env  # Éditer avec votre clé OpenAI
```

Exemple `.env` :
```
LLM_PROVIDER=openai
OPENAI_API_KEY=sk-votre-clé-api-ici
DUCKDB_MEMORY=4GB
CACHE_DIR=./data/cache
```

#### 3. Construire et lancer avec Docker Compose
```bash
docker-compose up -d
```

L'application sera accessible à : **http://votre-serveur:8000**

#### 4. Arrêter l'application
```bash
docker-compose down
```

#### 5. Voir les logs
```bash
docker-compose logs -f
```

---

## Option 2 : Déploiement direct sur VPS Linux

### Prérequis
- Ubuntu 20.04+ ou Debian 11+
- Python 3.10+
- Node.js 18+
- Git

### Étapes

#### 1. Cloner et installer
```bash
git clone https://github.com/diouck/openmapagents.git
cd openmapagents
chmod +x install.sh
./install.sh
```

#### 2. Configurer OpenAI
```bash
nano backend/.env
```

Ajouter :
```
LLM_PROVIDER=openai
OPENAI_API_KEY=sk-...
```

#### 3. Construire le frontend
```bash
cd frontend
npm run build
# Cela crée un dossier 'dist' avec l'application compilée
```

#### 4. Lancer le backend FastAPI
```bash
cd backend
source venv/bin/activate
python backend.py
```

#### 5. Servir le frontend avec Nginx (optionnel)
```bash
sudo apt install -y nginx

# Créer une config Nginx
sudo nano /etc/nginx/sites-available/openmapagents
```

Exemple config :
```nginx
upstream backend {
    server localhost:8000;
}

server {
    listen 80;
    server_name votre-domaine.com;

    # Frontend
    location / {
        root /path/to/openmapagents/frontend/dist;
        try_files $uri /index.html;
    }

    # Backend API
    location /api {
        proxy_pass http://backend;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

Activer la config :
```bash
sudo ln -s /etc/nginx/sites-available/openmapagents /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

---

## Option 3 : Systemd Service (démarrage automatique)

Créer un fichier service systemd pour que l'app démarre automatiquement :

```bash
sudo nano /etc/systemd/system/openmapagents.service
```

Contenu :
```ini
[Unit]
Description=OpenMap Agents
After=network.target

[Service]
Type=simple
User=www-data
WorkingDirectory=/home/user/openmapagents/backend
Environment="PATH=/home/user/openmapagents/backend/venv/bin"
Environment="OPENAI_API_KEY=sk-..."
ExecStart=/home/user/openmapagents/backend/venv/bin/python backend.py
Restart=always

[Install]
WantedBy=multi-user.target
```

Activer :
```bash
sudo systemctl daemon-reload
sudo systemctl start openmapagents
sudo systemctl enable openmapagents
systemctl status openmapagents
```

---

## Option 4 : Render.com (PaaS - gratuit)

### Étapes

1. Fork le repo sur GitHub
2. Aller à [render.com](https://render.com)
3. Créer un nouveau Web Service
4. Sélectionner votre repo
5. Configuration :
   - **Build command** : `pip install -r backend/requirements.txt && cd frontend && npm install && npm run build`
   - **Start command** : `python backend/backend.py`
   - **Environment** : Ajouter `OPENAI_API_KEY`

---

## Troubleshooting

### Port 8000 déjà utilisé
```bash
lsof -i :8000
kill -9 <PID>
```

### Logs Docker
```bash
docker-compose logs -f openmapagents
```

### Erreur de connexion API
Vérifier la clé OpenAI :
```bash
docker-compose exec openmapagents python -c "
import os
print(f'API Key configured: {bool(os.getenv(\"OPENAI_API_KEY\"))}')"
```

---

## Performance & Optimisation

Pour un meilleur performance sur production :

```bash
# Augmenter la mémoire DuckDB
export DUCKDB_MEMORY=8GB
export DUCKDB_THREADS=8

# Ou dans docker-compose.yml
environment:
  DUCKDB_MEMORY: 8GB
  DUCKDB_THREADS: 8
```

---

## Sauvegardes

Le cache DuckDB est stocké dans `./data/cache`. Pour sauvegarder :

```bash
tar -czf openmapagents-cache-$(date +%Y%m%d).tar.gz data/cache/
```
