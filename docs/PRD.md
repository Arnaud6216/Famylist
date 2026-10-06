# Product Requirements Document

## Le problème

**L’organisation de cadeaux (Noël, anniversaires...) souffre de plusieurs problèmes récurrents :**

- Le désordre des informations : Les idées de cadeaux par SMS, emails ou de vive voix. Résultat : on finit toujours par perdre l'info ou par oublier une envie importante.
- Le risque de doublons : Éviter d’acheter le même cadeau à quelqu’un à cause d’un manque d’organisation.
- La barrière technique : Beaucoup d'outils actuels sont trop chargés ou trop portés sur la pub. Cela décourage souvent les membres de la famille qui ne sont pas à l’aise avec l’informatique.

## Public cible (Personas)

### Valérie, 40 ans, la grande soeur

- **Profil :** Technophile modérée, c’est elle qui organise et centralise les besoins de sa famille.
- **Besoin :** Elle veut un outil où elle peut "jeter" des liens pour ajouter des idées cadeaux facilement et voir en un coup d'œil ce qui est déjà pris par les autre contributeurs de la liste.
- **Frustration :** Devoir expliquer 10 fois à la famille qu'il faut utiliser le mode incognito ou ne pas répondre sur le fil de discussion principal pour ne pas griller le cadeau.

### Lysiane, 69 ans, La maman

- **Profil :** Jeune retraitée, très présente pour ses enfants et petits-enfants. Elle maîtrise les bases, mais panique dès qu'il y a plus d'une page.
- **Besoin :** Elle veut consulter les listes de tous le monde au même endroit sans avoir à chercher 4 mails différents. Elle a besoin de clarté visuelle.
- **Frustration :** Devoir appeler Valérie tous les deux jours pour demander : "Tu es sûre que c'est ici qu'il faut cliquer ?"

### Bryan, 21 ans, Le neveu geek

- **Profil :** Jeune actif, descend 5 minutes pour manger du gâteau, toujours sur son smartphone, puis repart.
- **Besoin :** Consulter la liste immédiatement sans contrainte d'installation ni de compte, et réserver un cadeau en quelques secondes via un compte rapidement connecté.
- **Frustration :** Les formulaires d'inscription interminables avec trop d'étapes de validation.

## Proposition de Valeur Unique

- Le secret automatique : L’application gère elle-même la visibilité. Le destinataire ne peut pas savoir ce qui est réservé sur sa propre liste, préservant totalement l'effet de surprise.
- Consultation libre et universelle : Tout proche disposant du lien de partage (token sécurisé) accède instantanément à la liste vitrine en lecture seule, sans avoir à créer de compte.
- Réservation authentifiée et fiable : La réservation nécessite un compte connecté, assurant une responsabilisation contre les réservations abusives et permettant au contributeur de gérer ou annuler son cadeau à tout moment.
- Liens marchands universels : Possibilité d'associer un lien marchand vers n'importe quel site web (Amazon, Fnac, boutique locale, etc.) pour guider les proches dans l'achat (l'extraction automatique par scraping est planifiée pour la V2 afin de garantir une V1 simple et robuste).

## Fonctionnalité principale (V1)

Le cœur de l'application est un système de Listes Collaboratives Dynamiques. Techniquement, cela se décompose en trois actions indissociables :

    - La Création : Valérie crée une liste et y ajoute des idées via un formulaire de saisie rapide (titre obligatoire, prix estimé, commentaire, lien marchand et image optionnels).

    - Le Partage : L'application génère un lien sécurisé unique (token) que Valérie envoie à ses proches.

    - La Consultation/Action : Lysiane ou Bryan ouvrent le lien en lecture seule, visualisent les articles et leur état de disponibilité, puis se connectent pour réserver un cadeau en un clic.

## Métriques de succès

- Efficacité de l'ajout : Moins de 30 secondes pour ajouter un cadeau complet via le formulaire de saisie rapide.

- Accessibilité & Conversion : Consultation immédiate en 1 clic sans inscription ; parcours de réservation (connexion / inscription rapide incluse) réalisable en moins d'une minute.

- Fiabilité des réservations : Zéro doublon signalé sur un événement grâce à la gestion de la concurrence et à la traçabilité des utilisateurs connectés.

## Hors périmètre (V1)

- Scraping automatique d'URL : L'extraction automatisée des métadonnées e-commerce (titre, prix, photo) à partir d'un lien marchand est reportée à une prochaine version afin de garder un périmètre V1 simple, rapide à déployer et fiable.
- Pas de paiement intégré : L'application ne gère pas de cagnottes ni de transactions bancaires (on se contente de rediriger vers le site marchand).
- Pas de gestion de prix dynamique : On ne surveille pas les baisses de prix après l'ajout.
- Pas d'envoi de mail (en V1) : Tout se passe sur l'application via le partage par lien unique. Une version hybride combinant le partage de lien et l'ajout direct de membres par e-mail sera mise en place dans une prochaine version.
- Système de groupe (tribus) : sera implémenté dans une prochaine version.
- Secret Santa : Le tirage au sort automatisé sera implémenté dans une prochaine version.

## Hypothèses et Risques

- **Arbitrage technique : Report du scraping automatique en V2**

      Contexte : Les algorithmes de scraping de sites e-commerce tiers sont complexes et fragiles (mises à jour de balisage DOM, mécanismes anti-bots, captchas).
      Solution retenue : Pour la V1, saisie manuelle via un formulaire fluide et intuitif, avec possibilité de renseigner l'URL marchande pour les proches. Le moteur de scraping dédié sera développé lors d'une prochaine version.

- **Arbitrage architectural : Abandon de la réservation invité sans compte**

      Risque initial : Permettre aux invités non connectés de réserver entraînait des réservations fantômes (trolling), une rupture d'expérience en cas de fermeture du navigateur (perte du cookie/localStorage) et une complexité excessive de gestion de sessions éphémères.

      Solution retenue : Maintien de l'accès public en lecture seule pour la consultation de la liste, mais obligation d'authentification pour toute réservation. Le modèle de données est clarifié (`wishes.user_id`), la responsabilité est garantie et l'utilisateur peut modifier sa réservation depuis n'importe quel terminal.

- **Risque métier : Le "Conflit de Réservation"**

      Risque : Deux utilisateurs pourraient tenter de réserver le même article simultanément.

      Solution : Gestion de la concurrence au niveau de PostgreSQL (transactions / verrouillage pessimiste ou optimistic locking). Le premier clic valide la réservation, et la seconde requête reçoit un message d'erreur explicite avec rafraîchissement de l'état.
