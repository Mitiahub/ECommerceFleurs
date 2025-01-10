CREATE OR REPLACE VIEW view_produits_disponibles AS
SELECT 
    p.id_produit, 
    p.nom, 
    p.description, 
    p.prix, 
    c.nom AS categorie, 
    p.stock, 
    p.image
FROM 
    Produit p
JOIN 
    Categories c ON p.id_categorie = c.id_categorie
WHERE 
    p.stock > 0;


CREATE OR REPLACE VIEW view_produits_par_categorie AS
SELECT 
    c.nom AS categorie, 
    ARRAY_AGG(p.nom) AS produits
FROM 
    Produit p
JOIN 
    Categories c ON p.id_categorie = c.id_categorie
GROUP BY 
    c.nom;


CREATE VIEW view_commandes_utilisateur AS
SELECT c.id_commande, c.date, u.nom AS utilisateur, SUM(p.prix * ct.quantite) AS total
FROM Commande c
JOIN Utilisateur u ON c.id_utilisateur = u.id_utilisateur
JOIN Contient ct ON c.id_commande = ct.id_commande
JOIN Produit p ON ct.id_produit = p.id_produit
GROUP BY c.id_commande, c.date, u.nom;

CREATE VIEW view_details_commande AS
SELECT c.id_commande, p.nom AS produit, ct.quantite, (p.prix * ct.quantite) AS sous_total
FROM Contient ct
JOIN Commande c ON ct.id_commande = c.id_commande
JOIN Produit p ON ct.id_produit = p.id_produit;

CREATE VIEW view_utilisateurs AS
SELECT id_utilisateur, nom, email, role
FROM Utilisateur;

CREATE OR REPLACE VIEW view_produits_rupture AS
SELECT 
    p.id_produit, 
    p.nom, 
    c.nom AS categorie, 
    p.stock
FROM 
    Produit p
JOIN 
    Categories c ON p.id_categorie = c.id_categorie
WHERE 
    p.stock = 0;


CREATE VIEW view_produits_plus_vendus AS
SELECT p.id_produit, p.nom, SUM(ct.quantite) AS total_vendu
FROM Contient ct
JOIN Produit p ON ct.id_produit = p.id_produit
GROUP BY p.id_produit, p.nom
ORDER BY total_vendu DESC;

CREATE VIEW view_revenus_mensuels AS
SELECT DATE_TRUNC('month', c.date) AS mois, SUM(p.prix * ct.quantite) AS revenu_total
FROM Commande c
JOIN Contient ct ON c.id_commande = ct.id_commande
JOIN Produit p ON ct.id_produit = p.id_produit
GROUP BY DATE_TRUNC('month', c.date)
ORDER BY mois;

CREATE VIEW view_commandes_non_livrees AS
SELECT c.id_commande, c.date, u.nom AS utilisateur
FROM Commande c
JOIN Utilisateur u ON c.id_utilisateur = u.id_utilisateur
WHERE c.id_commande NOT IN (
    SELECT id_commande FROM Contient
    WHERE id_commande = c.id_commande
);
