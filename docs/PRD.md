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

- **Profil :** Jeune actif, descends 5 minutes pour manger du gâteau, toujours sur son smartphone, puis repart.
- **Besoin :** Consulter la liste et réserver un cadeau en moins de 30 secondes sans créer de compte.
- **Frustration :** Les formulaires d'inscription interminables et la validation d'email par lien reçu dans les spams.

## Proposition de Valeur Unique

- Le secret automatique : L’app gère elle-même qui voit quoi. Le destinataire ne peut pas savoir ce qui est réservé, sans qu'il ait besoin de bidouiller des réglages.
- Zéro inscription pour les invités : On peut consulter et réserver un cadeau juste avec un lien, sans créer de compte ni retenir un mot de passe.
- Scraping d'URL simplifié : En collant un lien marchand (Amazon, Fnac, etc.), l'application récupère automatiquement les informations du produit pour éviter une saisie manuelle.

## Fonctionnalité principale (V1)

Le cœur de l'application est un système de Listes Collaboratives Dynamiques. Techniquement, cela se décompose en trois actions indissociables :

    - La Création : Valérie crée une liste et y ajoute des idées (via le scraper).

    - Le Partage : L'application génère un lien sécurisé unique que Valérie envoie à sa tribu.

    - La Consultation/Action : Lysiane ou Bryan ouvrent le lien, voient les photos et réservent un cadeau en un clic.

## Métriques de succès

- Efficacité de l'ajout : Moins de 30 secondes pour ajouter un cadeau complet grâce au scraper.

- Accessibilité Invité : Réussite d'une réservation par un utilisateur tiers en moins de 3 clics à partir de l'ouverture du lien.

- Fiabilité des réservations : Zéro doublon signalé sur un événement grâce à la gestion des états en temps réel.

## Hors périmètre

- Pas de paiement intégré : L'application ne gère pas de cagnottes ni de transactions bancaires (on se contente de rediriger vers le site marchand).

- Pas de gestion de prix dynamique : On ne surveille pas les baisses de prix après l'ajout.

- Pas d'envoi de mail : Tout se passe sur l'application.

- Système de groupe (tribus) : sera implémenté dans une prochaine version.

- Secret Santa : Le tirage au sort automatisé sera implémenté dans une prochaine version.

## Hypothèses et Risques

- **Risque technique : Fragilité du scraping**

      Risque : Les informations du site marchand ne sont pas ou mal récupérées par l'outil de scraping.

      Solution : Formulaire de saisie manuelle en cas d'échec de l'extraction.

- **Hypothèse : Persistance de la session "Invité"**

  On part du principe qu'un invité doit pouvoir retrouver sa réservation s'il ferme son navigateur par erreur.

      Risque : Si l'invité n'a pas de compte, comment "annuler" une erreur de clic ?

      Solution : Utiliser les LocalStorages du navigateur ou des Cookies pour lier temporairement la réservation à l'appareil de l'invité sans qu'il ait besoin de se connecter.

- **Risque métier : Le "Conflit de Réservation"**

      Risque : Deux utilisateur pourrait réserver le même article en même temps.

      Solution : Gestion de la concurrence au niveau de PostgreSQL (transactions). Le premier clic verrouille la ligne en base de données, et le deuxième reçoit un message d'erreur.
