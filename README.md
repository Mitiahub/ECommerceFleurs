

# 🌸 Flora – E-Commerce de Fleurs

**Flora** est une application web de commerce électronique dédiée à la vente de fleurs. Développée en Java avec JSP/Servlets et PostgreSQL, elle offre une plateforme complète pour la gestion des produits, des commandes et des utilisateurs.

---

## 🛠️ Technologies Utilisées

- **Java (JSP/Servlets)** – 95,6 %
- **HTML/CSS** – 3,2 %
- **PLpgSQL (PostgreSQL)** – 1,2 %

---

## 📁 Structure du Projet

Le projet est organisé comme suit :

```

ECommerceFleurs/
├── WEB-INF/               # Fichiers de configuration Java EE
├── css/                   # Feuilles de style CSS
├── images/                # Images utilisées dans l'application
├── views/                 # Pages JSP (interface utilisateur)
│   ├── index.jsp          # Page d'accueil
│   ├── produits.jsp       # Liste des produits
│   ├── produit.jsp        # Détails d'un produit
│   ├── panier.jsp         # Panier d'achat
│   ├── paiement.jsp       # Page de paiement
│   ├── paiementSuccess.jsp# Confirmation de paiement
│   ├── paiementError.jsp  # Erreur de paiement
│   ├── inscription.jsp    # Inscription utilisateur
│   ├── connexion.jsp      # Connexion utilisateur
│   ├── utilisateur.jsp    # Profil utilisateur
│   ├── commandes.jsp      # Historique des commandes
│   ├── categories.jsp     # Liste des catégories
│   ├── promotions.jsp     # Promotions en cours
│   ├── contact.jsp        # Page de contact
│   └── admin/             # Interface d'administration
├── base.sql               # Script de création de la base de données
├── insert.sql             # Script d'insertion des données initiales
├── trigger.sql            # Déclencheurs pour la base de données
├── view.sql               # Vues SQL pour des requêtes spécifiques
├── afaire.txt             # Liste des tâches à réaliser
├── note.txt               # Notes diverses
├── compilation.txt        # Instructions de compilation
└── ...                    # Autres fichiers et dossiers
```


---

## 🚀 Fonctionnalités Principales

- **Catalogue de Produits** : Affichage des différentes fleurs disponibles.
- **Panier d'Achat** : Ajout et gestion des produits sélectionnés.
- **Processus de Commande** : Validation et traitement des commandes.
- **Espace Administrateur** : Gestion des produits, des commandes et des utilisateurs.
- **Authentification** : Inscription et connexion des utilisateurs.
- **Promotions** : Affichage des offres promotionnelles en cours.
- **Contact** : Formulaire de contact pour les utilisateurs.

---

## ⚙️ Installation et Exécution

1. **Cloner le dépôt** :

   ```bash
   git clone https://github.com/Mitiahub/ECommerceFleurs.git
   ```


2. **Configurer la base de données PostgreSQL** :

   - Créer une base de données nommée `ecommerce_fleurs`.
   - Exécuter les scripts SQL dans l'ordre suivant :
     - `base.sql`
     - `insert.sql`
     - `trigger.sql`
     - `view.sql`

3. **Configurer l'application Java** :

   - Importer le projet dans un IDE compatible (Eclipse, IntelliJ IDEA, NetBeans).
   - Configurer le serveur d'applications (Tomcat, GlassFish, etc.).
   - Déployer l'application et démarrer le serveur.

4. **Accéder à l'application** :

   - Ouvrir un navigateur web et naviguer vers `http://localhost:8080/ECommerceFleurs/views/index.jsp`.

---

## 📌 Notes Supplémentaires

- Le projet contient plusieurs fichiers `afaire.txt`, `note.txt` et `compilation.txt` qui fournissent des informations supplémentaires sur les tâches en cours, les notes de développement et les instructions de compilation.
- Assurez-vous que toutes les dépendances nécessaires sont correctement configurées dans votre environnement de développement.

---

## 📄 Licence

Ce projet est open-source et disponible sous la licence [MIT](LICENSE).

---

## 🤝 Contributions

Les contributions sont les bienvenues ! Si vous souhaitez améliorer le projet, veuillez suivre les étapes suivantes :

1. Forker le dépôt.
2. Créer une branche pour votre fonctionnalité (`git checkout -b feature/AmazingFeature`).
3. Commiter vos modifications (`git commit -m 'Add some AmazingFeature'`).
4. Pousser la branche (`git push origin feature/AmazingFeature`).
5. Ouvrir une Pull Request.

---

## 📬 Contact

Pour toute question ou suggestion, veuillez contacter [Mitiahub](https://github.com/Mitiahub).

