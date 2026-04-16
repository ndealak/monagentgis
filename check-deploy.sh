#!/bin/bash

echo "📋 Checklist de déploiement - OpenMap Agents"
echo "================================================"

# Variables
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✓${NC} $1 existe"
    else
        echo -e "${RED}✗${NC} $1 manquant"
    fi
}

check_var() {
    if [ -z "$1" ]; then
        echo -e "${RED}✗${NC} $2 non défini"
    else
        if [[ "$2" == *"KEY"* ]] || [[ "$2" == *"TOKEN"* ]]; then
            echo -e "${GREEN}✓${NC} $2 défini (premiers 10 chars: ${1:0:10}...)"
        else
            echo -e "${GREEN}✓${NC} $2 = $1"
        fi
    fi
}

echo ""
echo "📦 Fichiers Docker"
check_file "Dockerfile"
check_file "docker-compose.yml"
check_file ".env.example"

echo ""
echo "📚 Documentation"
check_file "DEPLOY.md"
check_file "QUICKSTART-DEPLOY.md"

echo ""
echo "⚙️ Configuration Backend"
check_file "backend/requirements.txt"
check_file "backend/requirements_agent.txt"

echo ""
echo "🎨 Configuration Frontend"
check_file "frontend/vite.config.js"
check_file "frontend/src/config.js"
check_file "frontend/package.json"

echo ""
echo "📝 Variable d'environnement"
if [ -f ".env" ]; then
    source .env
    check_var "$OPENAI_API_KEY" "OPENAI_API_KEY"
    check_var "$LLM_PROVIDER" "LLM_PROVIDER"
    check_var "$DUCKDB_MEMORY" "DUCKDB_MEMORY"
else
    echo -e "${YELLOW}⚠${NC} Créer .env à partir de .env.example"
fi

echo ""
echo "================================================================"
echo "Pour déployer sur votre serveur :"
echo ""
echo "1. Configurer le .env :"
echo "   cp .env.example .env"
echo "   nano .env  # Ajouter votre clé OpenAI"
echo ""
echo "2. Construire et lancer avec Docker :"
echo "   docker-compose build"
echo "   docker-compose up -d"
echo ""
echo "3. Accéder à l'app :"
echo "   http://localhost:8000"
echo ""
echo "================================================================"
