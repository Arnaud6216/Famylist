# Spécifications Fonctionnelles & User Stories (BDD / Gherkin)

## 1 - Création de compte & Inscription

### User Story :

En tant que Visiteur, je veux créer mon compte afin de commencer à organiser mes listes de souhaits et interagir avec celles de mes proches.

**Scénario 1 : Inscription nominale réussie**

    Étant donné que je suis un visiteur sans compte actif
    Lorsque je m'inscris avec mon prénom, mon nom, une adresse email valide et un mot de passe conforme
    Alors mon compte utilisateur est créé en base de données
    Et je suis automatiquement authentifié sur mon espace personnel

**Scénario 2 : Échec d'inscription avec email déjà utilisé (Doublon)**

    Étant donné qu'un compte existe déjà avec l'adresse email "jean.dupont@email.com"
    Lorsque je tente de m'inscrire avec cette même adresse email
    Alors le système bloque l'inscription
    Et un message d'erreur m'indique "Cette adresse email est déjà associée à un compte"
    Et mes informations saisies sont conservées dans le formulaire pour correction

**Scénario 3 : Échec de validation des données (Format invalide)**

    Étant donné que je renseigne des informations non conformes (mot de passe trop court ou email mal formé)
    Lorsque je valide le formulaire d'inscription
    Alors le système bloque la soumission côté client et côté API (HTTP 422)
    Et des messages d'aide contextuels m'indiquent les critères à respecter

---

## 2 - Gestion de liste de souhaits (CRUD)

### User Story :

En tant que Membre, je veux pouvoir créer, consulter, modifier ou supprimer une liste thématique afin de centraliser mes envies de cadeaux selon les événements.

**Scénario 1 : Création d'une nouvelle liste**

    Étant donné que je suis connecté à mon espace membre
    Lorsque je crée une liste intitulée "Noël 2026" avec une description optionnelle
    Alors la liste est enregistrée et associée à mon profil
    Et j'accède directement à l'espace de cette liste pour y ajouter mes envies

**Scénario 2 : Modification d'une liste existante**

    Étant donné que je consulte ma liste "Noël 2026"
    Lorsque je modifie son titre en "Noël en Famille"
    Alors les nouvelles informations sont persistées en base de données
    Et l'affichage de ma liste est immédiatement actualisé

**Scénario 3 : Suppression définitive d'une liste (Cascade)**

    Étant donné que je consulte ma liste "Noël en Famille"
    Lorsque je demande la suppression définitive de cette liste et que je confirme mon choix
    Alors la liste et l'ensemble des envies associées sont supprimées de façon atomique
    Et je suis redirigé vers mon tableau de bord avec une confirmation visuelle

**Scénario 4 : Échec de création/modification pour titre invalide**

    Étant donné que je soumets un formulaire de liste avec un titre vide ou dépassant la limite autorisée
    Lorsque je valide l'action
    Alors le système bloque l'enregistrement et signale le champ en erreur
    Et la modale de saisie reste ouverte pour permettre la correction

---

## 3 - Ajout d'article à une liste

### User Story :

En tant que Membre, je veux ajouter un article manuellement ou via son lien URL afin que l'application pré-remplisse les informations (titre, prix, image) tout en me laissant la possibilité de les ajuster.

**Scénario :** Ajout automatique via URL marchand

    Étant donné que je suis connecté et sur la page de ma liste "Noël 2026"
    Lorsque je saisis le lien d'un produit e-commerce valide dans le champ "Ajouter via un lien"
    Alors le système extrait et pré-remplit le titre, le prix indicatif et l'image du produit
    Et je peux ajuster les données avant de valider l'ajout dans ma liste

**Scénario :** Ajout manuel d'une envie

    Étant donné que je suis connecté et sur la page de ma liste
    Lorsque je renseigne manuellement un intitulé, une description et un prix estimatif
    Alors l'envie est enregistrée et immédiatement affichée sur ma liste

---

## 4 - Partage public d'une liste (Lien sécurisé)

### User Story :

En tant que Propriétaire d'une liste, je veux générer un lien de partage sécurisé (token) afin de permettre à mes proches de consulter ma liste en vitrine sans barrière à l'entrée.

**Scénario :** Génération et copie du lien de partage

    Étant donné que je suis le propriétaire de la liste "Noël 2026"
    Lorsque je clique sur l'action "Partager la liste"
    Alors le système génère un lien unique contenant un jeton d'accès sécurisé (token)
    Et je peux copier ce lien dans le presse-papier pour le transmettre à mes proches

---

## 5 - Consultation publique d'une liste partagée (Lecture seule)

### User Story :

En tant que Visiteur public (invité non connecté), je veux pouvoir consulter une liste de souhaits partagée via son lien sécurisé afin de voir les articles souhaités et leur disponibilité sans devoir créer de compte au préalable.

**Scénario 1 : Consultation en lecture seule d'une liste avec token valide**

    Étant donné que je dispose d'une URL de partage avec un token valide
    Lorsque j'accède à la page de la liste
    Alors la liste vitrine s'affiche en lecture seule avec le titre, la description et les envies
    Et chaque envie affiche ses informations (titre, photo, prix estimatif, lien marchand, commentaire)
    Et aucun badge de statut n'est affiché pour les articles non réservés afin de conserver une interface épurée
    Et seul un badge visuel "Réservé" est présent sur les articles ayant déjà été réservés
    Et l'identité des réservants reste masquée pour préserver la discrétion

**Scénario 2 : Accès avec un token inexistant ou invalide**

    Étant donné que je saisis une URL de partage avec un token inexistant ou révoqué
    Lorsque la page se charge
    Alors le système affiche une page d'erreur 404 "Liste introuvable ou lien expiré"
    Et aucun contenu privé n'est exposé

**Scénario 3 : Tentative d'action de réservation par un visiteur non connecté**

    Étant donné que je consulte une liste partagée en tant que visiteur anonyme
    Lorsque je clique sur le bouton "Réserver ce cadeau" sur une envie non réservée
    Alors le système affiche une modale d'invitation à la connexion ou à la création de compte
    Et mémorise l'envie ciblée pour finaliser la réservation immédiatement après authentification

---

## 6 - Réservation d'un cadeau par un utilisateur connecté

### User Story :

En tant qu'Utilisateur connecté (Membre), je veux pouvoir réserver une envie disponible sur la liste partagée d'un proche afin d'indiquer aux autres membres que ce cadeau est pris et éviter les doublons, tout en préservant la surprise pour le créateur de la liste.

**Scénario 1 : Réservation réussie d'un cadeau disponible**

    Étant donné que je suis authentifié sur Famylist
    Et que je consulte la liste partagée d'un tiers (dont je ne suis pas le propriétaire)
    Et que l'envie ciblée n'est pas encore réservée (user_id IS NULL et reserved_at IS NULL)
    Lorsque je clique sur "Réserver ce cadeau" et que je confirme
    Alors l'envie passe à l'état réservé
    Et mon identifiant utilisateur (`user_id`) et la date/heure courante (`reserved_at`) sont enregistrés en base
    Et l'envie m'affiche le badge "Réservé par vous" avec l'action "Annuler ma réservation"
    Et pour les autres contributeurs (visiteurs et membres), l'envie affiche le badge "Réservé" sans mon nom
    Et pour le propriétaire de la liste, aucun badge de réservation n'apparaît (surprise intacte)

**Scénario 2 : Tentative de réservation concurrente (conflit de réservation)**

    Étant donné que je consulte une envie sans badge (non réservée au chargement)
    Mais qu'un autre utilisateur a validé la réservation de cette envie une fraction de seconde avant moi
    Lorsque ma requête de réservation est traitée par le serveur
    Alors le serveur rejette ma transaction (conflit HTTP 409)
    Et l'interface m'avertit par un message : "Ce cadeau vient tout juste d'être réservé par un autre proche"
    Et l'affichage de l'envie est actualisé avec l'apparition du badge "Réservé"

**Scénario 3 : Interdiction d'auto-réservation sur sa propre liste**

    Étant donné que je suis le créateur et propriétaire de la liste
    Lorsque je visualise mes propres envies
    Alors le bouton "Réserver ce cadeau" n'est pas disponible (ou désactivé)
    Et le système rejette toute tentative de requête API de réservation émise par le propriétaire (HTTP 403 Forbidden)

---

## 7 - Annulation d'une réservation par son auteur

### User Story :

En tant qu'Utilisateur ayant réservé un cadeau, je veux pouvoir annuler ma réservation afin de libérer l'article si je ne peux plus l'offrir ou si je change d'avis.

**Scénario 1 : Annulation réussie par l'auteur de la réservation**

    Étant donné que je suis authentifié
    Et que j'ai préalablement réservé l'envie (wishes.user_id = mon_id)
    Lorsque je clique sur "Annuler ma réservation" et que je confirme
    Alors la clé étrangère `user_id` et l'horodatage `reserved_at` sont réinitialisés à NULL
    Et le badge "Réservé" disparaît instantanément de la carte
    Et le bouton d'action "Réserver ce cadeau" redevient accessible pour l'ensemble des contributeurs

**Scénario 2 : Tentative d'annulation non autorisée par un tiers**

    Étant donné qu'un article est réservé par un utilisateur A
    Lorsque l'utilisateur B tente d'envoyer une requête d'annulation de cette réservation
    Alors le serveur refuse l'opération via un Voter de sécurité (HTTP 403 Forbidden)
    Et l'état de réservation reste inchangé en base de données

---

# Règles de Gestion Métier (RG)

| Identifiant       | Domaine         | Règle de Gestion                                                                                                                                                                                                                              |
| :---------------- | :-------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **RG-CONSULT-01** | Consultation    | **Accès public en lecture seule :** Tout utilisateur possédant le lien de partage avec un token valide peut consulter la liste et ses envies en lecture seule, sans authentification obligatoire.                                             |
| **RG-CONSULT-02** | Confidentialité | **Préservation de la surprise :** Le propriétaire de la liste ne doit voir aucun statut ni détail de réservation sur sa propre liste. Le badge "Réservé" n'est visible que par les tiers (visiteurs et membres contributeurs).                |
| **RG-CONSULT-03** | Confidentialité | **Anonymat inter-contributeurs :** Pour les tiers, un article réservé affiche uniquement le badge "Réservé" sans divulguer l'identité du membre réservant (seul le membre ayant lui-même réservé voit "Réservé par vous").                    |
| **RG-CONSULT-04** | Ergonomie UI    | **Sobriété d'affichage :** Un article disponible (non réservé) n'affiche aucun badge de statut particulier. Seuls les articles réservés portent le badge visuel "Réservé".                                                                    |
| **RG-RESERV-01**  | Réservation     | **Authentification obligatoire :** Pour effectuer une réservation, l'utilisateur doit impérativement être authentifié avec un compte Famylist valide (`users.user_id` non NULL).                                                              |
| **RG-RESERV-02**  | Réservation     | **Disponibilité préalable :** Une envie ne peut être réservée que si son statut actuel est disponible (`wishes.user_id IS NULL` et `wishes.reserved_at IS NULL`).                                                                             |
| **RG-RESERV-03**  | Réservation     | **Horodatage et attribution :** Lors de la réservation, le système associe de manière atomique l'ID de l'utilisateur connecté (`wishes.user_id`) et la date/heure serveur courante (`wishes.reserved_at`).                                    |
| **RG-RESERV-04**  | Réservation     | **Interdiction d'auto-réservation :** Un utilisateur ne peut en aucun cas réserver une envie sur une liste dont il est le propriétaire.                                                                                                       |
| **RG-RESERV-05**  | Réservation     | **Droit d'annulation strict :** Seul l'utilisateur ayant réservé une envie (`auth_user.id == wishes.user_id`) a le droit d'annuler sa réservation. L'annulation remet `user_id` et `reserved_at` à `NULL` et supprime le badge "Réservé".     |
| **RG-RESERV-06**  | Données         | **Suppression du mode invité non connecté :** Aucun stockage volatile (nom/email invité) ni entité de réservation invitée n'est toléré dans le système. Toutes les réservations sont strictement rattachées au compte utilisateur centralisé. |
