# 🚀 Déploiement rapide avec Docker

## 1. Sur votre serveur (VPS Linux)

```bash
# Cloner le projet
git clone https://github.com/diouck/openmapagents.git
cd openmapagents

# Copier le fichier d'exemple et configurer
cp .env.example .env
nano .env
# → Remplacer sk-... par votre clé OpenAI complète

# Construire l'image Docker
docker-compose build

# Lancer l'application
docker-compose up -d

# Vérifier le statut
docker-compose logs -f
```

**L'app est maintenant accessible à** : `http://votre-serveur:8000`

## 2. Accéder à l'application

- **Frontend** : http://votre-serveur:8000 (page d'accueil)
- **API** : http://votre-serveur:8000/api
- **Docs API** : http://votre-serveur:8000/docs

## 3. Gérer l'application

```bash
# Arrêter
docker-compose down

# Redémarrer
docker-compose restart

# Voir les logs
docker-compose logs -f openmapagents

# Reconstruire après mise à jour
docker-compose build --no-cache
docker-compose up -d
```

## 4. HTTPS avec Nginx (optionnel mais recommandé)

```bash
sudo apt install -y nginx certbot python3-certbot-nginx

# Config Nginx
sudo nano /etc/nginx/sites-available/openmapagents
```

Ajouter :
```nginx
upstream app {
    server localhost:8000;
}

server {
    listen 80;
    server_name votre-domaine.com;
    
    location / {
        proxy_pass http://app;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

Activer :
```bash
sudo ln -s /etc/nginx/sites-available/openmapagents /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx

# HTTPS gratuit avec Let's Encrypt
sudo certbot --nginx -d votre-domaine.com
```

**Maintenant accessible à** : `https://votre-domaine.com`

## 5. Mise à jour

```bash
cd openmapagents
git pull origin main
docker-compose build --no-cache
docker-compose up -d
```

## Besoin d'aide ?

Consultez [DEPLOY.md](./DEPLOY.md) pour plus d'options de déploiement.
