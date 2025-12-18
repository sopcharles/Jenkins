# Marvin Jenkins - Configuration as Code

Ce projet configure une instance Jenkins automatisée avec Docker, utilisant **Jenkins Configuration as Code (JCasC)** et **Job DSL** pour une configuration entièrement reproductible.

## 📁 Structure du projet

```
.
├── docker-compose.yml   # Orchestration Docker
├── Dockerfile           # Image Jenkins personnalisée
├── job_dsl.groovy       # Définition des jobs Jenkins
├── my_marvin.yml        # Configuration JCasC (utilisateurs, rôles, sécurité)
└── README.md
```

## 🚀 Démarrage rapide

### Prérequis

- Docker
- Docker Compose

### Configuration des variables d'environnement

Créez un fichier `.env` à la racine du projet avec les mots de passe des utilisateurs :

```bash
USER_CHOCOLATEEN_PASSWORD=votre_mot_de_passe
USER_VAUGIE_G_PASSWORD=votre_mot_de_passe
USER_I_DONT_KNOW_PASSWORD=votre_mot_de_passe
USER_NASSO_PASSWORD=votre_mot_de_passe
```

### Lancement

```bash
docker-compose up -d --build
```

Jenkins sera accessible sur : **http://localhost:8080**

## 👥 Utilisateurs et rôles

| Utilisateur   | Nom     | Rôle     | Description                              |
|---------------|---------|----------|------------------------------------------|
| chocolateen   | Hugo    | admin    | Administrateur Marvin                    |
| vaugie_g      | Garance | gorilla  | Gestion complète des jobs                |
| i_dont_know   | Jeremy  | ape      | Membre de l'équipe pédagogique           |
| nasso         | Nassim  | assist   | Assistant (lecture seule + workspace)    |

### Permissions par rôle

| Rôle    | Permissions                                                              |
|---------|--------------------------------------------------------------------------|
| admin   | Overall/Administer (accès complet)                                       |
| gorilla | Read, Build, Workspace, Create, Configure, Delete, Move, Cancel jobs    |
| ape     | Read, Build, Workspace jobs                                              |
| assist  | Read, Workspace jobs (lecture seule)                                     |

## 🔧 Jobs préconfigurés

### Dossier `Tools`

#### 1. `clone-repository`
Clone un dépôt Git.

**Paramètre :**
- `GIT_REPOSITORY_URL` : URL du dépôt Git à cloner

#### 2. `SEED`
Job générateur qui crée dynamiquement des jobs de build pour des projets GitHub.

**Paramètres :**
- `GITHUB_NAME` : Propriétaire/nom du dépôt (ex: `EpitechIT31000/chocolatine`)
- `DISPLAY_NAME` : Nom d'affichage du job créé

**Le job généré effectue :**
1. `make fclean`
2. `make`
3. `make tests_run`
4. `make clean`

Avec un déclencheur SCM polling toutes les minutes.

## 🔌 Plugins installés

- `cloudbees-folder` - Gestion des dossiers
- `configuration-as-code` - JCasC
- `credentials` - Gestion des credentials
- `github` - Intégration GitHub
- `job-dsl` - Job DSL
- `role-strategy` - Gestion des rôles
- `ws-cleanup` - Nettoyage du workspace
- `script-security` - Sécurité des scripts
- `structs` - Structures de base
- `instance-identity` - Identité de l'instance

## 📦 Volumes Docker

- `jenkins_home` : Persiste les données Jenkins entre les redémarrages

## 🛑 Arrêt

```bash
docker-compose down
```

Pour supprimer également les données persistées :

```bash
docker-compose down -v
```

## 📝 Notes

- L'inscription de nouveaux utilisateurs est désactivée (`allowsSignup: false`)
- Les mots de passe sont injectés via des variables d'environnement pour la sécurité
- Le message d'accueil : *"Welcome to the Chocolatine-Powered Marvin Jenkins Instance."*

