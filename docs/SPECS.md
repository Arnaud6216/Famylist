# User stories (Gerkhin) + Use case

## 1 - Création de compte

### User Story :

En tant que Visiteur, je veux créer mon profil pour commencer à organiser mes idées de cadeaux et rejoindre un cercle de partage.

**Scénario :** Inscription sur l'application

**Etant donné que** je suis un visiteur sans compte actif
**Lorsque** je m'inscris avec un nom, une adresse email valide et un mot de passe
**Alors** mon compte utilisateur est créé
**Et** je suis automatiquement authentifié sur mon espace personnel

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

## 2 - Gestion de liste de souhaits

### User Story :

En tant que Membre, je veux pouvoir créer, consulter, éditer ou supprimer une liste thématique afin de centraliser mes envies, que ce soit pour une occasion particulière ou simplement pour garder une trace de mes besoins.

**Scénario :** Création d'une liste

    Étant donné que je suis connecté à mon espace membre
    Lorsque je crée une liste intitulée "Noël 2026"
    Alors la liste est enregistrée et associée à mon profil
    Et j'accède directement à l'espace de cette liste pour commencer à y ajouter mes envies

**Scénario :** Modification d'une liste existante

    Etant donné que je consulte ma liste "Noël 2026"
    Lorsque je renomme cette liste en "Noël en Famille"
    Alors les nouvelles informations sont enregistrées
    Et ma liste est immédiatement mise à jour à l'écran

**Scénario :** Suppression d'une liste

    Étant donné que je consulte ma liste "Noël en Famille"
    Lorsque je demande la suppression définitive de cette liste et que je confirme mon choix
    Alors la liste et l'ensemble des articles associés sont définitivement supprimés
    Et je suis redirigé vers mon tableau de bord

### Use Case

#### Basic Scenario

Objectif : Permettre au Membre d'ajouter une nouvelle liste à son espace.

Acteur principal : Membre

- Step 1 : Le Membre sollicite la création d'une liste depuis son tableau de bord.

- Step 2 : Le système ouvre la modale de création.

- Step 3 : Le Membre renseigne les informations et valide.

- Step 4 : Le système contrôle la validité des champs obligatoires.

- Step 5 : Le système persiste la nouvelle liste en base de données pour l'utilisateur connecté.

- Step 6 : Le système ferme la modale et redirige le Membre vers la page de détail de sa nouvelle liste.

#### Extensions (Alternate Paths)

**E1 : Édition d'une liste (Update & Annulation)**

Divergence : Depuis la page de détail de la liste".

- Step 1 : Le Membre déclenche la modification de la liste.

- Step 2 : Le système ouvre la modale pré-remplie avec les informations courantes.

- Step 3 : Le Membre modifie les informations.

- Step 4 :
  - Option A (Validation) : Le Membre enregistre. Le système met à jour les informations en base de données et actualise
    l'affichage.

  - Option B (Annulation) : Le Membre annule. Le système referme la modale sans appliquer de modification.

**E2 : Suppression (Delete)**

Divergence : Depuis la page de détail de la liste.

- Step 1 : Le Membre déclenche la suppression de la liste.

- Step 2 : Le système demande une confirmation explicite pour prévenir toute suppression accidentelle.

- Step 3 : Le Membre confirme.

- Step 4 : Le système supprime la liste et réalise la suppression en cascade de toutes les envies associées.

- Retour : Le système redirige le Membre vers son tableau de bord.

**E3 : Erreur de saisie (Validation)**

Divergence : À l'étape de validation du Basic Scenario ou de l'E1.

- Step 1 : Le Membre valide un titre vide ou non conforme.

- Step 2 : Le système bloque l'enregistrement et affiche un message d'erreur.

- Retour : La modale reste ouverte pour permettre la correction.

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
