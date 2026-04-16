# 🚀 Comment pousser les changements vers GitHub

Vous avez 2 options :

## Option 1 : Fork le repo sur votre compte

### 1.1 Créer un fork sur GitHub
1. Allez à [https://github.com/diouck/openmapagents](https://github.com/diouck/openmapagents)
2. Cliquez sur **"Fork"** (haut à droite)
3. Cela crée votre propre copie : `https://github.com/votre-username/openmapagents`

### 1.2 Configurer le remote
```bash
# Voir le remote actuel
git remote -v

# Changer vers votre fork
git remote set-url origin https://github.com/votre-username/openmapagents.git

# Vérifier
git remote -v
```

### 1.3 Pousser les changements
```bash
git push origin main
```

**Maintenant vos changements sont sur votre fork !**

---

## Option 2 : Ajouter un collaborateur

Si vous êtes propriétaire du repo d'origine :

1. Allez dans **Settings → Collaborators**
2. Ajoutez les utilisateurs qui peuvent pousser

---

## Commandes utiles après la configuration

```bash
# Voir les remotes
git remote -v

# Pousser une branche
git push origin main

# Voir l'historique
git log --oneline -5

# Vérifier le statut
git status
```

---

## 📋 Le commit incluant les changements :

```
a688ffd 🚀 Add complete Contabo VPS deployment support
│
├── 📦 Fichiers Docker
│   ├── Dockerfile (multi-stage build)
│   └── docker-compose.yml (orchestration)
│
├── 📚 Documentation Contabo
│   ├── CONTABO-DEPLOY.md
│   ├── CONTABO-READY.txt
│   └── README-CONTABO.txt
│
├── 🚀 Scripts d'installation
│   ├── scripts/install-contabo.sh
│   ├── scripts/setup-nginx.sh
│   ├── scripts/setup-systemd.sh
│   └── scripts/check-contabo.sh
│
├── 🔧 Modifications du code
│   ├── backend/backend.py (optimisé production)
│   └── frontend/vite.config.js (build production)
│
└── ⚙️ Configuration
    └── .env.example
```

---

## Vérifier que tout est prêt :

```bash
# Voir le commit
git show a688ffd

# Voir les fichiers du commit
git show --name-only a688ffd

# Vérifier les changements
git diff HEAD~1
```
