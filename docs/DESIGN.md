### Conception UX/UI & Maquettes

- **Maquettes Figma (Basse Fidélité & Haute Fidélité) :**  
  👉 [Lien vers Figma](https://www.figma.com/design/j8MZ9n32qECkVor2IFlqNB/Famylist?node-id=58-381&t=XMtRT1fEOcfsPnGt-1)

- **Zoning :**  
  Le schéma est disponible dans le dossier [`docs/mockup/zoning.png`](./mockup/zoning.png) :

---

### Charte Graphique & Identité Visuelle

#### Palette de couleurs

- **Bleu Nuit (`#001E37`)** : Couleur dominante pour les titres et la structure (contraste fort 17:1).
- **Bleu Canard (`#32627C`)** : Couleur de marque pour la navigation et les boutons de consultation.
- **Vert Action (`#2E7D32`)** : Couleur d'action principale pour les créations, calibrée pour être 100% conforme aux normes d'accessibilité RGAA / WCAG A (ratio 4.6:1).

\* **Fond neutre (`#F5F7FA`) & Cartes blanches (`#FFFFFF`)** : Offrent une lecture reposante et sans surcharge cognitive.

#### Typographie

- **Titres** : `Poppins` (géométrique et chaleureuse).
- **Textes & Interface** : `Inter` (optimisée pour la lisibilité sur écran).

#### Démarche Responsive (Mobile First)

L'application est conçue pour s'adapter dynamiquement :

- **Desktop** : Grille multi-colonnes (2 à 3 listes par ligne).
- **Mobile** : Affichage 1 colonne avec zones tactiles de 44px minimum pour une utilisation fluide à une main.

### Design Tokens

L'interface repose sur des **Design Tokens** (variables sémantiques réutilisables). Cette approche facilite la maintenance, l'homogénéité visuelle et l'adaptation responsive.

| Catégorie        | Nom de la variable | Rôle sémantique / Intention                                |
| :--------------- | :----------------- | :--------------------------------------------------------- |
| **Couleur**      | `--color-primary`  | Couleur dominante pour la structure et les titres          |
| **Couleur**      | `--color-brand`    | Couleur de marque pour la navigation et les consultations  |
| **Couleur**      | `--color-success`  | Couleur d'action positive et de création (conforme RGAA)   |
| **Couleur**      | `--color-danger`   | Actions destructives et alertes (suppression, déconnexion) |
| **Couleur**      | `--bg-app`         | Fond général de l'application                              |
| **Couleur**      | `--bg-surface`     | Fond des cartes de contenu et des modales                  |
| **Couleur**      | `--text-secondary` | Textes secondaires, métadonnées et sous-titres             |
| **Typographie**  | `--font-heading`   | Police réservée aux titres et à l'identité                 |
| **Typographie**  | `--font-body`      | Police réservée au texte courant et à l'interface          |
| **Échelle Typo** | `--font-size-h1`   | Taille du titre principal (adaptatif Desktop / Mobile)     |
| **Échelle Typo** | `--font-size-body` | Taille du corps de texte (adaptatif Desktop / Mobile)      |
| **Espacement**   | `--spacing-page`   | Marge extérieure de l'écran (adaptatif Desktop / Mobile)   |
| **Espacement**   | `--spacing-gap`    | Espace entre les cartes de la grille                       |
| **Arrondi**      | `--radius-btn`     | Rayon de courbure des boutons et champs de formulaire      |
| **Arrondi**      | `--radius-card`    | Rayon de courbure des cartes de listes et d'envies         |
| **Arrondi**      | `--radius-modal`   | Rayon de courbure des fenêtres modales                     |
