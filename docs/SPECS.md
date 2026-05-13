# User stories (Gerkhin)

## 1 - Création de compte

**Scénario :** Inscription sur l'application

**User Story :** En tant que Visiteur, je veux créer mon profil pour commencer à organiser mes idées de cadeaux et rejoindre un cercle de partage.

**Etant donné que** je suis sur la page d'inscription
**Lorsque** je saisis un email valide, un mot de passe, un nom et que je valide le formulaire
**Alors** mon compte est créé en base de données
**Et** je suis redirigé vers mon tableau de bord avec un message de succès

## 2 - Création de liste

**Scénario :** Création d'une liste d'envies

**User Story :** En tant que Membre, je veux créer une liste thématique pour centraliser mes envies, que ce soit pour une occasion particulière ou simplement pour garder une trace de mes besoins.

**Etant donné que** je suis connecté et sur mon tableau de bord
**Lorsque** je clique sur "Créer une liste" et que je saisis le titre "Noël 2026"
**Alors** la liste est enregistrée et apparaît dans mon espace personnel
**Et** je suis redirigé vers la page de gestion de cette liste

## 3 - Ajout d'article via Scraper

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

## 6 - Protection de la surprise

**Scénario :** Masquage du statut de réservation au créateur de la liste

**User Story :** En tant que Membre consultant ma propre liste, je veux que le statut de réservation des articles me soit masqué pour conserver l'effet de surprise jusqu'au moment de l'événement.

**Étant donné que** je suis le Membre propriétaire de ma propre liste "Noël 2026"
**Et** qu'un article a été réservé par un Visiteur invité
**Lorsque** j'affiche la page de ma liste
**Alors** je ne dois voir aucune mention "Réservé" afin de préserver la surprise
