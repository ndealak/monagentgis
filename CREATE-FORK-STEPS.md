# 🚀 CRÉER UN FORK - INSTRUCTIONS PAS À PAS

## Étape 1 : Créer le fork sur GitHub (2 minutes)

### 1.1 Allez sur la page du repo
Ouvrir dans votre navigateur :
```
https://github.com/diouck/openmapagents
```

### 1.2 Cliquez sur "Fork"
- Cherchez le bouton **"Fork"** en haut à droite
- Cliquez dessus
- GitHub va créer une copie du repo sur votre compte

### 1.3 Attendez que ce soit fait
Vous verrez une page avec votre fork :
```
https://github.com/votre-username/openmapagents
```

**✅ C'est fait !**

---

## Étape 2 : Configurer le remote local (exécuter ces commandes)

### 2.1 Récupérer votre username GitHub
```bash
# Si vous ne le savez pas, exécutez :
gh auth status | grep "account"
```

### 2.2 Configurer le remote pour pointer vers votre fork
```bash
cd /workspaces/openmapagents

# Remplacer YOUR-USERNAME par votre vrai username GitHub
git remote set-url origin https://github.com/YOUR-USERNAME/openmapagents.git

# Ajouter un remote "upstream" vers le repo original
git remote add upstream https://github.com/diouck/openmapagents.git

# Vérifier
git remote -v
```

**Output attendu :**
```
origin   https://github.com/YOUR-USERNAME/openmapagents.git (fetch)
origin   https://github.com/YOUR-USERNAME/openmapagents.git (push)
upstream https://github.com/diouck/openmapagents.git (fetch)
upstream https://github.com/diouck/openmapagents.git (noop)
```

---

## Étape 3 : Pousser vos changements

```bash
cd /workspaces/openmapagents

# Pousser vers votre fork
git push origin main

# Vérifier sur GitHub
echo "✓ https://github.com/YOUR-USERNAME/openmapagents"
```

**✅ Vos changements sont maintenant sur votre fork !**

---

## Étape 4 : Ajouter des collaborateurs (DEV team)

Une fois le fork sur GitHub :

1. Allez sur votre repo GitHub :
   ```
   https://github.com/YOUR-USERNAME/openmapagents
   ```

2. Cliquez sur **Settings** (Paramètres)

3. Dans le menu à gauche, cliquez sur **Collaborators**

4. Cliquez sur **Add people** (Ajouter des personnes)

5. Entrez les usernames (ou emails) des collaborateurs

6. Ils recevront une invitation à collaborer

**Ils pourront alors :**
- Clone le repo
- Créer des branches
- Pousser leurs changements
- Créer des Pull Requests

---

## Commandes résumées (du terminal)

```bash
# 1. Changer le remote vers votre fork
git remote set-url origin https://github.com/YOUR-USERNAME/openmapagents.git

# 2. Ajouter l'upstream
git remote add upstream https://github.com/diouck/openmapagents.git

# 3. Pousser vos changements
git push origin main

# 4. Voir vos changements
git log --oneline -3

# 5. Vérifier votre fork sur GitHub
# https://github.com/YOUR-USERNAME/openmapagents
```

---

## 💡 Après avoir pushé

### Créer une Pull Request (optionnel)
Si vous voulez que diouck merge vos changements :

1. Allez sur votre fork GitHub
2. Vous verrez un bouton **"Pull Request"**
3. Cliquez pour créer une PR
4. diouck pourra alors vérifier et merger dans le repo d'origine

### Mettre à jour votre fork avec les changements du repo original
```bash
# Récupérer les changements du repo original
git fetch upstream
git merge upstream/main

# Pousser sur votre fork
git push origin main
```

---

## Pour vos collaborateurs

Une fois qu'ils sont ajoutés comme collaborateurs :

```bash
# 1. Cloner votre fork
git clone https://github.com/YOUR-USERNAME/openmapagents.git
cd openmapagents

# 2. Créer une branche pour leurs changements
git checkout -b feature/mon-feature

# 3. Faire leurs modifications
# ... edit files ...

# 4. Commit et push
git add .
git commit -m "Add my feature"
git push origin feature/mon-feature

# 5. Créer une Pull Request sur GitHub
# → Vous pourrez reviewer et merger dans main
```

---

## 📋 Résumé du workflow collaboratif

```
Collaborateurs
       ↓
Clonent votre fork
       ↓
Créent des branches (feature/xyz)
       ↓
Pushent leurs changements
       ↓
Créent des Pull Requests
       ↓
Vous reviewez et mergez
       ↓
Les changements sont dans main
       ↓
Mission accomplie ! ✅
```

---

## ⚠️ Important

**NE PAS OUBLIER :**
1. Remplacer `YOUR-USERNAME` par votre vrai username
2. Cliquer sur "Fork" manuellement sur GitHub
3. Exécuter les commandes dans le terminal

Une fois ces étapes faites, vous pourrez :
✅ Collaborer avec d'autres DEV
✅ Pousser vos changements
✅ Faire des Pull Requests
✅ Gérer les permissions
