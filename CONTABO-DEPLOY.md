# 🚀 Guide de déploiement Contabo VPS

Ce guide vous guidera étape par étape pour déployer OpenMap Agents sur votre VPS Contabo.

## 💻 Prérequis Contabo

Vous devrez avoir :
- ✅ Un VPS Contabo actif (Ubuntu 20.04 ou 22.04)
- ✅ Accès SSH root (ou utilisateur avec sudo)
- ✅ Une clé OpenAI API
- ✅ (Optionnel) Un domaine DNS pointant vers votre IP Contabo

## 📋 Étape 1 : Premiers pas avec votre Contabo VPS

### 1.1 Se connecter à votre serveur

```bash
# Remplacer par votre IP Contabo
ssh root@12.34.56.78

# Ou si vous utilisez un utilisateur non-root
ssh ubuntu@12.34.56.78
```

### 1.2 Trouver votre IP

Si vous ne savez pas votre IP Contabo :
1. Allez dans votre [Dashboard Contabo](https://contabo.com)
2. **VPS Management** → **Your VPS** → Cherchez "IP Address"

Exemple : `203.0.113.42`

## 🔨 Étape 2 : Installation automatique (recommandé)

### 2.1 Copier et exécuter le script d'installation

```bash
# Se connecter à votre serveur
ssh root@votre-ip-contabo

# Cloner le projet avec les scripts
git clone https://github.com/diouck/openmapagents.git
cd openmapagents

# Rendre les scripts exécutables
chmod +x scripts/*.sh

# Exécuter le script d'installation
./scripts/install-contabo.sh
```

**Cela va installer automatiquement :**
- ✅ Docker et Docker Compose
- ✅ Nginx
- ✅ Certbot (SSL Let's Encrypt)
- ✅ Git et outils système

### 2.2 Attendre la fin (5-10 minutes)

Une fois terminé, le script affichera les prochaines étapes.

---

## ⚙️ Étape 3 : Configuration OpenAI

### 3.1 Configurer votre clé API

```bash
cd ~/openmapagents
cp .env.example .env
nano .env
```

Remplacer cette ligne :
```
OPENAI_API_KEY=sk-...
```

Par votre vraie clé OpenAI (ex: `sk-proj-abc123xyz...`)

Pour quitter nano : `Ctrl+X` → `Y` → `Enter`

### 3.2 Optionnel : Augmenter les ressources

Pour un meilleur performance sur Contabo, éditer `docker-compose.yml` :

```bash
nano docker-compose.yml
```

Changer :
```yaml
environment:
  DUCKDB_MEMORY: 4GB      # Augmenter à 8GB si vous avez 8GB+ RAM
  DUCKDB_THREADS: 4       # Augmenter au nombre de CPU cores
```

Voir votre configuration : `free -h` et `nproc` (nombre de cores)

---

## 🚀 Étape 4 : Lancer l'application

### 4.1 Build et démarrage

```bash
# Se placer dans le répertoire
cd ~/openmapagents

# Construire l'image Docker (10-15 min première fois)
docker-compose build

# Lancer l'application
docker-compose up -d

# Vérifier que tout fonctionne
docker-compose logs -f
```

**Attendez que vous voyiez :**
```
INFO:     Application startup complete.
```

Puis appuyez sur `Ctrl+C` pour quitter les logs.

### 4.2 Vérifier l'application

Ouvrir dans votre navigateur :
```
http://votre-ip-contabo:8000
```

Remplacer `votre-ip-contabo` par votre IP réelle (ex: `http://203.0.113.42:8000`)

✅ Si vous voyez la carte interactive → **C'est bon !**

---

## 🌐 Étape 5 : Configuration Nginx + SSL (Optionnel mais recommandé)

### 5.1 Vous avez un domaine ?

Si vous avez un domaine (ex: `maps.example.com`) :

```bash
cd ~/openmapagents

# Vérifier que votre domaine pointe vers votre IP Contabo
nslookup maps.example.com
# Doit retourner votre IP (203.0.113.42)

# Configurer Nginx + SSL automatiquement
./scripts/setup-nginx.sh maps.example.com
```

**Cela va :**
- ✅ Configurer Nginx comme reverse proxy
- ✅ Obtenir un certificat SSL gratuit avec Let's Encrypt
- ✅ Rediriger HTTP → HTTPS automatiquement

Votre app sera accessible à : `https://maps.example.com`

### 5.2 Sans domaine ? 

Si vous utilisez juste l'IP :
```bash
# Accéder par HTTP (non sécurisé)
http://203.0.113.42:8000

# Vous ne pouvez pas avoir HTTPS sans domaine
# (C'est une limitation technique de Let's Encrypt)
```

---

## 🔄 Étape 6 : Auto-démarrage au reboot

Pour que l'app redémarre automatiquement en cas de reboot serveur :

```bash
cd ~/openmapagents
chmod +x scripts/setup-systemd.sh
./scripts/setup-systemd.sh
```

Vérifier :
```bash
sudo systemctl status openmapagents
```

---

## 📊 Gestion de l'application

### Voir l'état :
```bash
docker-compose ps
```

### Voir les logs en direct :
```bash
cd ~/openmapagents
docker-compose logs -f
```

### Redémarrer :
```bash
cd ~/openmapagents
docker-compose restart
```

### Arrêter complètement :
```bash
cd ~/openmapagents
docker-compose down
```

### Reprendre après arrêt :
```bash
cd ~/openmapagents
docker-compose up -d
```

### Mettre à jour depuis GitHub :
```bash
cd ~/openmapagents
git pull origin main
docker-compose build --no-cache
docker-compose up -d
```

---

## 🆘 Troubleshooting

### L'app plante au démarrage ?

```bash
cd ~/openmapagents
docker-compose logs --tail=50
```

Vérifier :
1. **Clé OpenAI valide** : `grep OPENAI_API_KEY .env`
2. **Espace disque** : `df -h`
3. **RAM disponible** : `free -h`

### Port 8000 occupé ?

```bash
lsof -i :8000
sudo kill -9 <PID>
docker-compose up -d
```

### Nginx ne démarre pas après `setup-nginx.sh` ?

```bash
sudo nginx -t          # Voir les erreurs
sudo systemctl restart nginx
```

### Certificat SSL ne se renouvelle pas ?

Les certificats Let's Encrypt se renouvellent automatiquement. Vérifier :
```bash
sudo certbot renew --dry-run
```

---

## 📈 Performance Contabo

Pour optimiser sur Contabo :

### Vérifier votre config :
```bash
free -h        # RAM
nproc          # Nombre de CPU cores
df -h          # Espace disque
```

### Exemples de tuning :

**Contabo Entry (2 vCPU, 4GB RAM) :**
```yaml
DUCKDB_MEMORY: 2GB
DUCKDB_THREADS: 2
```

**Contabo Standard M (4 vCPU, 8GB RAM) :**
```yaml
DUCKDB_MEMORY: 6GB
DUCKDB_THREADS: 4
```

**Contabo Standard L (8 vCPU, 16GB RAM) :**
```yaml
DUCKDB_MEMORY: 12GB
DUCKDB_THREADS: 8
```

---

## 🔐 Sécurité conseillée

```bash
# 1. Mettre à jour le système tôt et souvent
sudo apt update && sudo apt upgrade -y

# 2. Configurer un firewall
sudo ufw enable
sudo ufw allow 22/tcp    # SSH
sudo ufw allow 80/tcp    # HTTP
sudo ufw allow 443/tcp   # HTTPS

# 3. Ajouter une clé SSH (au lieu d'un mot de passe)
# Voir : https://docs.contabo.com/docs/manage-contabo/initial-setup

# 4. Ne jamais partager votre clé OpenAI !
# Stocker dans .env (qui est dans .gitignore ✓)
```

---

## 📚 Liens utiles

- [Documentation Contabo](https://docs.contabo.com)
- [Console Contabo](https://contabo.com)
- [OpenAI API Keys](https://platform.openai.com/api-keys)
- [Guide Docker](https://docs.docker.com)

---

## ✅ Checklist finale

- [ ] SSH connecté à Contabo
- [ ] `install-contabo.sh` exécuté
- [ ] `.env` configuré avec clé OpenAI
- [ ] `docker-compose up -d` lancé
- [ ] App accessible à `http://ip:8000`
- [ ] (Optionnel) Domaine + SSL configuré
- [ ] Service systemd activé
- [ ] Firewall sécurisé

---

## 🎉 Bravo !

Votre application OpenMap Agents est maintenant en ligne sur Contabo ! 

**Pour tout problème**, consultez les logs :
```bash
cd ~/openmapagents
docker-compose logs -f
```

Ou créez une issue sur GitHub : https://github.com/diouck/openmapagents/issues
