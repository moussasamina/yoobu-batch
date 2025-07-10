**Prise en main complète** du projet `YOOBU-LOGISTIC-BATCH`.

---

# 📘 Documentation – YOOBU LOGISTIC BATCH

## 🧠 Objectif

Ce projet est un **programme batch Node.js (TypeScript)** qui permet de **synchroniser régulièrement deux bases de données MySQL** :

- `YB_WP_DB` : la base de données **WordPress** de Yoobu.
- `YB_LOGISTIC_DB` : la base de données de l’application **logistique** de Yoobu.

---

## ⚙️ Prérequis

- **Node.js** v21 ou supérieur
- **npm** (fourni avec Node.js)
- **MySQL** local pour développement
- Accès aux dumps de base de donnée racine (Sur Wordpress)

---

## 🚀 Installation

### 1. Cloner le dépôt

```bash
git clone --branch main https://github.com/moussasamina/yoobu-batch
cd yoobu-batch
```

### 2. Créer un fichier `.env`

Copiez le fichier `.env.example` :

```bash
cp .env.example .env
```

Puis, **renseignez les credentials** pour les deux bases :

---

## 🧪 Mise en place des bases de données

### ✅ Étapes pour environnement de développement :

1. **Récupérer un dump de la base WordPress (`YB_WP_DB`)** :

   - Demander un dump récent (via phpMyAdmin ou CLI).
   - Importer le dump dans MySQL local :

     ```bash
     mysql -u root -p YB_WP_DB < dump_wp.sql
     ```

2. **Initialiser la base logistique (`YB_LOGISTIC_DB`)** localement :

   - Si vous l’utilisez pour la première fois :

     ```bash
     npx prisma db push --schema=db/prisma_yb_logistic/schema.prisma
     ```

---

## 📦 Installation des dépendances

```bash
npm ci
```

---

## 🔧 Compilation (TypeScript → JavaScript)

```bash
npm run build
```

> Le build génère les fichiers compilés dans le dossier `./build`

---

## ▶️ Exécution du script de synchronisation

```bash
npm run sync:db
```

Ce script :

- Charge les données depuis la base WordPress (via Prisma).
- Fait la correspondance et alimente la base logistique.

---

## 📁 Structure du projet

```
.
├── src/                   # Code source en TypeScript
│   └── lib/               # Modules de synchronisation
│       ├── db.ts
│    index.ts
│    sync-db.ts
│
├── db/
│   ├── prisma_yb_logistic/schema.prisma   # Modèle Prisma de la base logistique
│   └── prisma_yb_wp/schema.prisma         # Modèle Prisma de la base WordPress
│
├── build/                # Code compilé en JavaScript
├── .env                  # Variables d’environnement (non commit)
├── .env.example          # Exemple de fichier .env
├── package.json          # Scripts et dépendances
├── tsconfig.json         # Configuration TypeScript
├── Jenkinsfile           # (Optionnel) Déploiement CI/CD
```

---

## 📌 Scripts utiless

| Script               | Description                                 |
| -------------------- | ------------------------------------------- |
| `npm ci`             | Installe les dépendances clean              |
| `npm run build`      | Compile les fichiers TypeScript             |
| `npm run sync:db`    | Exécute la synchronisation                  |
| `npx prisma db push` | Pousse le schéma Prisma vers la DB logistic |

---

## 🛡️ Bonnes pratiques

- Toujours travailler avec un dump **à jour** de `YB_WP_DB`.
- Vérifier les données critiques avant d’écraser des données dans `YB_LOGISTIC_DB`.
- Ne jamais commit le fichier `.env`.

---

By moussasamina
