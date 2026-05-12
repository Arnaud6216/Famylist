# User stories (Gerkhin)

## 1 - Création de compte

**Scénario :** Inscription réussie d'un nouvel utilisateur
**Etant donné que** je suis sur la page d'inscription
**Lorsque** je saisis un email valide, un mot de passe et que je valide le formulaire
**Alors** mon compte est créé en base de données
**Et** je suis redirigé vers mon tableau de bord avec un message de succès

## 2 - Création de liste

**Scénario :** Création d'une liste d'envies
**Etant donné que** je suis connecté et sur mon tableau de bord
**Lorsque** je clique sur "Créer une liste" et que je saisis le titre "Noël 2026"
**Alors** la liste est enregistrée et apparaît dans mon espace personnel
**Et** je suis redirigé vers la page de gestion de cette liste

## 3 - Ajout d'article via Scraper

**Scénario :** Ajout automatique d'un article via une URL
**Etant donné que** je suis sur la page de ma liste "Noël 2026"
**Lorsque** je colle le lien d'un produit Amazon dans le champ "Ajouter via lien"
**Alors** le système pré-remplit automatiquement le titre, le prix et l'image du produit
**Et** je peux valider l'ajout pour voir l'article apparaître instantanément dans ma liste
**Ou** je peux modifier manuellement ces informations avant de valider l'ajout dans le cas ou le scrapping échoue

## 4 - Partage de liste

**Scénario :** Génération d'un lien de partage public
**Etant donné que** je consulte ma liste "Noël 2026"
**Lorsque** je clique sur le bouton "Partager"
**Alors** un lien unique contenant un jeton sécurisé (token) est généré
**Et** je peux copier ce lien pour l'envoyer à ma tribu

## 5 - Réservation sans compte

**Scénario :** Réserver un cadeau en tant qu'invité
**Étant donné que** je suis un invité accédant à la liste via un lien partagé
**Lorsque** je clique sur le bouton "Offrir" en face d'un article
**Alors** l'article est marqué comme "Réservé" pour tous les autres invités
**Et** je reçois une confirmation visuelle que mon action est enregistrée sans avoir eu à me connecter

## 6 - Protection de la surprise

**Scénario :** Masquage du statut de réservation au créateur de la liste
**Étant donné que** Valérie consulte sa propre liste "Noël 2026"
**Et** qu'un article a été réservé par Bryan
**Lorsque** la page s'affiche pour Valérie
**Alors** elle ne doit voir aucune mention "Réservé" afin de préserver la surprise
