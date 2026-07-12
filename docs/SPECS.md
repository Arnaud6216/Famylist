# User stories (Gerkhin) + Use case

## 1 - Création de compte

### User Story :

En tant que Visiteur, je veux créer mon profil pour commencer à organiser mes idées de cadeaux et rejoindre un cercle de partage.

**Scénario :** Inscription sur l'application

**Etant donné que** je suis sur la page d'inscription
**Lorsque** je saisis un email valide, un mot de passe, un nom et que je valide le formulaire
**Alors** mon compte est créé en base de données
**Et** je suis redirigé vers mon tableau de bord

### Use Case

#### Basic Scenario

Objectif : Permettre à un visiteur de devenir membre en enregistrant ses informations.

Acteur principal : Visiteur

- Step 1 : Le Visiteur accède à la page d'inscription.

- Step 2 : Le système affiche le formulaire d'adhésion (Nom, Email, Mot de passe).

- Step 3 : Le Visiteur renseigne ses informations et valide.

- Step 4 : Le système vérifie la conformité des données et l'absence de doublon.

- Step 5 : Le système enregistre le nouveau profil en base de données.

- Step 6 : Le système connecte automatiquement l'utilisateur et le redirige vers son tableau de bord.

#### Extensions (Alternate Paths)

**E1 : Email déjà utilisé (Doublon)**

Divergence : À l'étape 4 du Basic Scenario.

- Step 1 : Le système détecte que l'adresse email existe déjà en base de données.

- Step 2 : Le système bloque l'inscription et affiche un message d'erreur spécifique.

- Retour : Le système maintient le Visiteur sur le formulaire pour qu'il puisse modifier l'email.

**E2 : Format de données invalide (Validation)**

Divergence : À l'étape 4 du Basic Scenario.

- Step 1 : Le Visiteur valide des informations non conformes (ex: mot de passe trop court, email mal formé).

- Step 2 : Le système identifie les champs erronés et affiche les messages d'aide correspondants.

- Retour : Le système maintient le Visiteur sur le formulaire pour correction.

## 2 - Gestion de liste

### User Story :

En tant que Membre, je veux pouvoir créer, consulter, éditer ou supprimer une liste thématique afin de centraliser mes envies, que ce soit pour une occasion particulière ou simplement pour garder une trace de mes besoins.

**Scénario :** Création d'une liste

    Etant donné que je suis connecté sur mon tableau de bord et que je me rends sur la page "Mes listes"
    Lorsque je crée une liste intitulée "Noël 2026"
    Alors la liste est enregistrée et apparaît dans la page 'Mes listes'
    Et je suis redirigé vers cette page

**Scénario :** Édition d'une liste

    Etant donné que je consulte le détail de ma liste "Noël 2026"
    Lorsque je renomme cette liste en "Noël en Famille"
    Alors le titre est mis à jour et je suis redirigé sur la page "Mes listes".

**Scénario :** Suppression d'une liste

    Etant donné que je suis sur mon tableau de bord
    Lorsque je décide de supprimer la liste "Noël en Famille" et que je confirme cette action
    Alors la liste disparaît de mon espace personnel
    Et toutes les données liées à cette liste sont effacées

### Use Case

#### Basic Scenario

Objectif : Permettre au Membre d'ajouter une nouvelle liste à son espace.

Acteur principal : Membre

- Step 1 : Le Membre accède à la page "Mes listes" de son tableau de bord.

- Step 2 : Le Membre clique sur le bouton "Créer une liste".

- Step 3 : Le système affiche un formulaire de saisie.

- Step 4 : Le Membre saisit le titre de la liste (ex: "Noël 2026") et valide.

- Step 5 : Le système enregistre la liste en base de données pour l'ID du membre.

- Step 6 : Le système ferme le formulaire et rafraîchit la page "Mes listes" pour afficher la nouvelle liste parmi les autres.

#### Extensions (Alternate Paths)

**E1 : Édition d'une liste (Update & Annulation)**

Divergence : À partir de la page "Mes listes".

- Step 1 : Le Membre clique sur l'icône "modifier" (sur la carte) ou sur le bouton de modification dans la liste.

- Step 2 : Le système redirige le Membre vers la page d'édition.

- Step 3 : Le Membre modifie les informations.

- Step 4 :
  - Option A (Validation) : Le Membre clique sur "Enregistrer". Le système met à jour la base de données.

  - Option B (Annulation) : Le Membre clique sur "Annuler" ou le bouton retour. Aucune modification n'est enregistrée.

- Retour : Dans les deux cas, le système redirige le Membre vers la page "Mes listes".

**E2 : Suppression (Delete)**

Divergence : Peut se produire sur la page "Mes listes".

- Step 1 : Le Membre clique sur l'icône "Supprimer" (sur la carte) ou sur le bouton de suppression dans la liste.

- Step 2 : Le système demande une confirmation.

- Step 3 : Le Membre confirme.

- Step 4 : Le système supprime la liste et tout son contenu.

- Retour : Le système redirige (ou maintient) le Membre sur la page "Mes listes".

**E3 : Erreur de saisie (Validation)**

Divergence : À l'étape de validation du Basic Scenario ou de l'E1.

- Step 1 : Le Membre valide un titre vide ou non conforme.

- Step 2 : Le système bloque l'enregistrement et affiche un message d'erreur.

- Retour : Le système maintient le Membre sur le formulaire pour correction.

<!-- ## 3 - Ajout d'article via Scraper

**Scénario :** Ajout automatique d'un article via une URL

**User Story :** En tant que Membre, je veux ajouter un article via son lien URL pour que l'application remplisse les détails à ma place (titre, prix, image) tout en me laissant la liberté de les corriger si besoin.

**Etant donné que** je suis sur la page de ma liste "Noël 2026"
**Lorsque** je colle le lien d'un produit Amazon dans le champ "Ajouter via lien"
**Alors** le système pré-remplit automatiquement le titre, le prix et l'image du produit
**Ou** je peux modifier manuellement ces informations avant de valider l'ajout dans le cas ou le scrapping échoue
**Et** je peux valider l'ajout pour voir l'article apparaître instantanément dans ma liste

## 4 - Partage de liste

**Scénario :** Génération d'un lien de partage public

**User Story :** En tant que Membre, je veux générer un lien de partage unique pour permettre à mes proches d'accéder à ma liste sans les obliger à créer un compte.

**Etant donné que** je consulte ma liste "Noël 2026"
**Lorsque** je clique sur le bouton "Partager"
**Alors** un lien unique contenant un jeton sécurisé (token) est généré
**Et** je peux copier ce lien pour l'envoyer à mon entourage

## 5 - Réservation sans compte

**Scénario :** Réserver un cadeau en tant que Visiteur

**User Story :** User Story : En tant que Visiteur, je veux pouvoir réserver un cadeau sur une liste partagée pour informer les autres que l'article est pris, sans avoir à m'inscrire sur la plateforme.

**Étant donné que** je suis un invité accédant à la liste via un lien partagé
**Lorsque** je clique sur le bouton "Offrir" en face d'un article
**Alors** l'article est marqué comme "Réservé" pour tous les autres participants
**Et** je reçois une confirmation visuelle que mon action est enregistrée sans avoir eu à me connecter
