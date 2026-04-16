#!/bin/bash

# Script de configuration du fork après création manuelle

GITHUB_USERNAME="ndealak"
REPO_NAME="openmapagents"
REPO_URL="https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║  Configuration du fork pour collaborateurs                  ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "📝 Configuration :"
echo "  Username        : $GITHUB_USERNAME"
echo "  Fork URL        : $REPO_URL"
echo ""

# Vérifier si on est dans le bon répertoire
if [ ! -d ".git" ]; then
    echo "❌ Erreur : Pas dans un répertoire Git"
    echo "Exécutez ce script depuis /workspaces/openmapagents"
    exit 1
fi

echo "🔧 Configuration des remotes..."
echo ""

# 1. Configurer origin vers le fork
echo "1️⃣  Configuration de origin vers votre fork..."
git remote set-url origin "$REPO_URL"
echo "   ✓ origin → $REPO_URL"

# 2. Ajouter upstream vers le repo d'origine
echo ""
echo "2️⃣  Ajout de upstream vers le repo d'origine..."
if git remote get-url upstream >/dev/null 2>&1; then
    echo "   ✓ upstream existe déjà"
else
    git remote add upstream https://github.com/diouck/openmapagents.git
    echo "   ✓ upstream → https://github.com/diouck/openmapagents.git"
fi

# 3. Vérifier
echo ""
echo "3️⃣  Vérification des remotes..."
echo ""
git remote -v
echo ""

# 4. Pousser vers le fork
echo "4️⃣  Poussée des changements vers votre fork..."
echo ""
git push origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║  ✓ Configuration complète !                               ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo ""
    echo "🎉 Votre fork est maintenant à jour avec tous les changements !"
    echo ""
    echo "📊 Votre fork GitHub :"
    echo "   → https://github.com/$GITHUB_USERNAME/$REPO_NAME"
    echo ""
    echo "📚 Prochaines étapes :"
    echo "   1. Ajouter des collaborateurs (Settings → Collaborators)"
    echo "   2. Partager le lien avec votre équipe"
    echo "   3. Vos collaborateurs peuvent cloner et contribuer"
    echo ""
    echo "💡 Commandes utiles :"
    echo "   git fetch upstream      → Récupérer les changements du repo original"
    echo "   git merge upstream/main → Fusionner dans votre main"
    echo "   git push origin main    → Pousser vos changements"
    echo ""
else
    echo ""
    echo "⚠️  Erreur lors de la poussée"
    echo ""
    echo "Vérifications :"
    echo "  1. Le fork existe-t-il sur GitHub ?"
    echo "  2. Êtes-vous connecté en tant que $GITHUB_USERNAME ?"
    echo "  3. GitHub est-il accessible ?"
    exit 1
fi
