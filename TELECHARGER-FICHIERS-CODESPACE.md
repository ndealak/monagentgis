📥 COMMENT TÉLÉCHARGER LES FICHIERS DU CODESPACE

Voici les 3 méthodes pour récupérer les fichiers.

═══════════════════════════════════════════════════════════

MÉTHODE 1️⃣  : Télécharger une ARCHIVE ZIP (PLUS FACILE)
──────────────────────────────────────────────────────

✅ C'est la plus simple !

ÉTAPE 1 : Dans le Codespace, ouvrez le Terminal
  - Ctrl+` (backtick) OU Terminal → New Terminal

ÉTAPE 2 : Exécutez cette commande :

  cd /workspaces/openmapagents && \
  git archive --format=zip HEAD -- \
    .env.example \
    CONTABO-DEPLOY.md \
    CONTABO-READY.txt \
    DEPLOY.md \
    DEPLOYMENT-READY.txt \
    Dockerfile \
    QUICKSTART-DEPLOY.md \
    README-CONTABO.txt \
    backend/backend.py \
    docker-compose.yml \
    frontend/package-lock.json \
    frontend/package.json \
    frontend/src/App.jsx \
    frontend/vite.config.js \
    scripts/ \
    > openmapagents-deployment.zip

ÉTAPE 3 : Allez sur le fichier créé
  - Dans l'explorateur de fichiers VS Code (gauche)
  - Cherchez "openmapagents-deployment.zip"
  - Clic droit → Download
  
  OU
  
  - Clic droit sur le fichier dans l'explorateur
  - Sélectionnez "Download"

✅ Fichier sur votre machine ! Décompressez-le.

═══════════════════════════════════════════════════════════

MÉTHODE 2️⃣  : Télécharger fichier par fichier
──────────────────────────────────────────────

📝 Plus lent mais plus précis.

1. Dans l'explorateur VS Code (gauche)
   
2. Pour chaque fichier :
   - Clic droit sur le fichier
   - "Download"
   
   Fichiers à télécharger :
   
   ✓ .env.example
   ✓ CONTABO-DEPLOY.md
   ✓ CONTABO-READY.txt
   ✓ DEPLOY.md
   ✓ DEPLOYMENT-READY.txt
   ✓ Dockerfile
   ✓ QUICKSTART-DEPLOY.md
   ✓ README-CONTABO.txt
   ✓ docker-compose.yml
   
   ✓ backend/backend.py
   ✓ frontend/package-lock.json
   ✓ frontend/package.json
   ✓ frontend/src/App.jsx
   ✓ frontend/vite.config.js
   
   ✓ scripts/README.md
   ✓ scripts/install-contabo.sh
   ✓ scripts/setup-nginx.sh
   ✓ scripts/setup-systemd.sh

═══════════════════════════════════════════════════════════

MÉTHODE 3️⃣  : Télécharger tout le dossier openmapagents
────────────────────────────────────────────────────

1. VS Code → Explorer (gauche)

2. Clic droit sur le dossier "openmapagents"

3. "Download Folder"

✅ Tout est téléchargé !

⚠️ Attention : Cela télécharge TOUT y compris node_modules et cache
   (très lourd !)

═══════════════════════════════════════════════════════════

APRÈS TÉLÉCHARGEMENT
────────────────────

Sur votre machine locale :

1. Décompressez le ZIP : openmapagents-deployment.zip

2. Naviguez dans le dossier

3. Utilisez la SOLUTION 1 :

   git remote add codespace https://github.com/diouck/openmapagents.git
   git fetch codespace main
   git merge codespace/main
   git push origin main

   ✅ Les fichiers sont sur GitHub !

═══════════════════════════════════════════════════════════

🎯 RECOMMANDATION

MÉTHODE 1 (Archive ZIP) est la meilleure :
  ✓ Plus rapide
  ✓ Plus facile
  ✓ Tout en un seul fichier
  ✓ Facile à extraire

═══════════════════════════════════════════════════════════

💡 ASTUCE : Voir les fichiers du commit

Pour voir exactement quels fichiers sont dans le commit :

  cd /workspaces/openmapagents
  git show a688ffd --name-only

Cela affiche la liste de tous les fichiers modifiés.

═══════════════════════════════════════════════════════════
