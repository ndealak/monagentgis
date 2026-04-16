# Stage 1 : Builder frontend
FROM node:18-alpine as frontend-builder
WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm install
COPY frontend/ .
RUN npm run build

# Stage 2 : Backend + Frontend
FROM python:3.12-slim

WORKDIR /app

# Installer les dépendances système
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Backend
COPY backend/requirements.txt backend/requirements_agent.txt ./backend/
RUN pip install --no-cache-dir -r backend/requirements.txt && \
    pip install --no-cache-dir -r backend/requirements_agent.txt

# Copier le backend
COPY backend/ ./backend/

# Copier le frontend construit (dist)
COPY --from=frontend-builder /app/frontend/dist ./frontend/dist

# Créer les répertoires de cache
RUN mkdir -p data/cache

# Exposer les ports
EXPOSE 8000

# Variables d'environnement par défaut
ENV PYTHONUNBUFFERED=1
ENV OVERTURE_RELEASE=2026-03-18.0
ENV DUCKDB_MEMORY=4GB

# Lancer le backend
CMD ["python", "backend/backend.py"]
