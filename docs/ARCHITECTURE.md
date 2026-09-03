## Patron de conception

Pour le projet FamyList, j'ai choisi une architecture multicouche basée sur le pattern MVC (Modèle-Vue-Contrôleur), adaptée à un environnement découplé (API / Client).

**Pourquoi ce choix ?**

- **Séparation des rôles :** L'isolation de la logique métier (Backend) par rapport à la logique de présentation (Frontend) garantit une meilleure scalabilité. En communiquant exclusivement via une API REST, le Frontend peut évoluer (refonte UI, changement de framework) sans impacter l'intégrité du système central.

- **Standardisation et Maintenance :** Le MVC est le standard natif du framework Symfony. Adopter cette structure garantit la maintenabilité du code par n'importe quel développeur familier avec l'écosystème PHP.

- **Évolutivité du système :** En structurant le Backend comme une API fournissant du JSON, le système reste ouvert à de potentielles nouvelles interfaces (application mobile, extension de navigateur) sans avoir à réécrire la logique serveur.

## Rôle des couches côté Backend

- **Couche de Présentation (Routing & Controllers) :** C’est le point d'entrée de l'API et qui gère le cycle requête/réponse. Les contrôleurs se contentent de réceptionner les requêtes, de valider les données qui arrivent via des DTO (Data Transfer Objects), et de renvoyer une réponse JSON une fois que le traitement est fini.

- **Couche Métier (Services) :** Centralise la logique métier pure (ex: algorithme de scraping). Cette couche est isolée pour faciliter les tests unitaires et la réutilisation des composants.

- **Couche de Persistance (Repositories & ORM Doctrine) :** C’est le pont entre le code PHP et la base de données. L’ORM Doctrine permet de manipuler des objets plutôt que de faire des requêtes SQL "en dur". Les Repositories servent à centraliser les requêtes spécifiques (comme récupérer toutes les listes d'un utilisateur) pour ne pas polluer les contrôleurs.

- **Couche de Données (SGBD PostgreSQL) :** PostgreSQL Assure parfaitement la gestion des types de données complexes, le stockage persistant et la cohérence des liens entre les données.

## Sécurité

Pour protéger les données utilisateurs, j'applique les principes de sécurité recommandés par l'ANSSI à chaque étage de l'application :

- **Validation des entrées :** Considérer toute donnée provenant du Frontend comme potentiellement corrompue. J'utilise donc le Validator de Symfony au niveau des DTO et des Entités. Chaque champ est passé au filtre de contraintes strictes (Regex, longueur, type) avant d'être traité par la couche métier ou envoyé en base de données.

- **Authentification et gestion des secrets :**
  - **Gestion de la session :** L'authentification est sécurisée par le composant Security de Symfony. À chaque connexion, un identifiant de session unique est généré. Pour protéger cette connexion, le cookie de session est configuré avec les drapeaux HttpOnly (invisible pour les scripts JS, contre le vol de session) et Secure (transmis uniquement via HTTPS).
  - **Cloisonnement des accès API :** L'endpoint de consultation publique d'une liste (`GET /api/shared-lists/{token}`) est accessible aux visiteurs anonymes (lecture seule). En revanche, les actions de mutation d'état (`POST /api/wishes/{id}/reserve` et `DELETE /api/wishes/{id}/reserve`) sont strictement protégées par le firewall Symfony (`#[IsGranted('ROLE_USER')]`), imposant une authentification active.

  - **Hachage :** Les mots de passe ne sont jamais stockés en clair. J'utilise l'algorithme Argon2 via le composant Security de Symfony.

  - **Variables d'environnement :** Toutes les données sensibles sont stockées dans un fichier .env, qui est exclu du versioning (Git) pour éviter toute fuite de secrets sur les dépôts distants.

- **Gestion des permissions (Voters) :** Pour éviter les failles de type IDOR et respecter la logique métier, Symfony intègre un système de Voters :
  - `ListVoter` : vérifie que l'utilisateur est le propriétaire de la liste avant toute modification ou suppression (`list.user_id == user.id`).
  - `WishVoter` :
    - Action `RESERVE` : vérifie que l'utilisateur connecté n'est pas le propriétaire de la liste (`wish.list.user_id != user.id`) et que le cadeau est disponible (`reserved_by IS NULL`).
    - Action `CANCEL_RESERVATION` : vérifie que seul l'utilisateur ayant réservé le cadeau (`wish.user_id == user.id`) peut annuler la réservation.

- **Protection contre les attaques XSS :** Vue.js intègre une protection native : toutes les données insérées dans le HTML sont automatiquement "échappées", ce qui empêche l'injection de scripts malveillants.

- **CORS (Cross-Origin Resource Sharing) :** Pour sécuriser les échanges entre le Frontend et l'API. Seul le domaine autorisé de l'application est autorisé à consommer l'API, empêchant ainsi des sites tiers malveillants d'effectuer des requêtes à l'insu de l'utilisateur.

- **Le nettoyage du Scraping (Sanitisation) :** Lors du scraping des sites marchands, les données récupérées (titres, descriptions) sont nettoyées et filtrées avant d'être persistées via HTML Sanitizer de Symfony. On s'assure ainsi qu'aucun code malveillant provenant d'un site tiers ne soit injecté dans notre base de données.

## Eco-conception

L'architecture de l'application intègre des pratiques d'éco-conception visant à réduire l'empreinte environnementale de l'application tout en maximisant ses performances techniques.

- **Optimisation des transferts (Payloads & Pagination) :** Afin de limiter la bande passante consommée, l'API utilise des Contextes de Sérialisation pour ne renvoyer que les données strictement nécessaires à l'interface. En complément, l'implémentation d'une pagination systématique des ressources volumineuses pour éviter au serveur de traiter et d'envoyer des volumes de données inutiles.

- **Lazy Loading :** Pour économiser les ressources processeur du client, j'utilise le Lazy Loading sur les composants Vue.js et les images. Cela garantit que seuls les éléments visibles par l'utilisateur sont téléchargés et rendus, réduisant ainsi la consommation de batterie sur mobile et le temps de chargement initial.

- **Minification et formats légers :** Tous les assets (CSS, JavaScript) sont minifiés via Vite pour réduire leur poids au maximum.

- **Mutualisation du Scraping :** Le système vérifie d'abord si le produit existe déjà en base de données. Si oui, on réutilise les informations et l'image déjà stockées.

- **Interface sobre :** Une interface épurée qui utilise des icônes vectorielles (SVG) légères plutôt que des images iconographiques lourdes. Le design évite les animations CSS complexes qui sollicitent inutilement le processeur.

- **Nettoyage automatique des données obsolètes :** Une liste d'envies pour un anniversaire ou Noël perd de son utilité après l'événement. Un principe de sobriété consiste à mettre en place une stratégie de cycle de vie des données : les listes "expirées" depuis longtemps ou les images de cadeaux supprimés sont automatiquement nettoyées par une tâche planifiée (Cron job)

## Stack

### Frontend

- **Vue.js 3 :** Pour la création d'une interface utilisateur réactive et performante (Single Page Application). Son architecture basée sur les composants facilite la maintenance et l'évolution de l'interface de gestion des listes.

- **Vite :** Outil de build de nouvelle génération utilisé pour le développement et le bundle final. Il permet une minification optimale des assets (JS et CSS) et un rechargement à chaud (Hot Module Replacement) très rapide.

- **SCSS (Sass) :** Préprocesseur CSS utilisé pour structurer les feuilles de style de manière modulaire.

### Backend

- **PHP 8+:** Langage serveur principal, choisi pour ses performances accrues et son typage strict qui sécurise la manipulation des objets métier.

- **Symfony 7:** Framework Backend de référence, sélectionné pour sa modularité et la puissance de ses composants de sécurité. Il offre un cadre rigoureux (MVC/Service Pattern) indispensable pour un projet structuré.

- **Nginx :** Serveur web de production et proxy inversé. Il est chargé de réceptionner les requêtes HTTP/HTTPS du Frontend, de servir directement les fichiers statiques s'il y en a, et de transmettre les requêtes dynamiques à PHP-FPM (Symfony) de manière ultra-performante.

### Base de données

- **PostgreSQL 17:** Pour sa robustesse et sa gestion stricte de l'intégrité des données.

- **Doctrine (ORM) :** Couche d'abstraction permettant d'interagir avec la base de données via des objets PHP. Il assure la sécurité des requêtes (prévention native des injections SQL) et facilite la gestion des relations entre les utilisateurs, les listes et les produits.

### Outils

- **Docker :** Utilisation de conteneurs pour garantir un environnement de développement identique sur tous les postes, facilitant ainsi le déploiement et la reproductibilité du projet.

- **Composer :** Gestionnaire de dépendances PHP pour l'installation et la mise à jour sécurisée des bibliothèques du framework Symfony.

- **NPM :** Gestionnaire de paquets pour les dépendances Frontend

- **Git/Github:** Pour le versioning, avec l'utilisation de Github Project pour la gestion du projet
