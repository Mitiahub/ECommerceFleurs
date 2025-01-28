-- Ajout des catégories (doit être exécuté avant les produits)
INSERT INTO Categories (nom) VALUES
('Bouquets'),
('Fleurs Solo'),
('Plantes Decoratives'),
('Amour et Romances'),
('Anniversaire'),
('Mariage'),
('Sympathie et Condoleances');
INSERT INTO Categories (nom) VALUES ('Sensible à la Lumière');


-- Ajout des produits
INSERT INTO Produit (nom, description, prix, id_categorie, stock, image) VALUES
-- Bouquets
('Bouquet Elegant', 'Bouquet de roses rouges parfait pour toutes les occasions', 20.00, 1, 10, 'images/bouquets/bouquet1.jpg'),
('Bouquet Joyeux', 'Bouquet de tulipes multicolores pour egayer votre journee', 25.00, 1, 15, 'images/bouquets/bouquet2.jpg'),
('Bouquet Raffine', 'Un arrangement sophistique pour des occasions speciales', 30.00, 1, 8, 'images/bouquets/bouquet3.jfif'),
('Bouquet Champetre', 'Un bouquet naturel compose de fleurs sauvages', 18.00, 1, 12, 'images/bouquets/bouquet4.jpg'),
('Bouquet Luxueux', 'Une composition luxueuse avec des fleurs exotiques', 45.00, 1, 5, 'images/bouquets/bouquet5.jfif'),

-- Fleurs Solo
('Rose Rouge', 'Rose rouge symbolisant amour et la passion', 5.00, 2, 50, 'images/fleurs_solo/fleurs1.jpg'),
('Lys Blanc', 'Un lys blanc elegant pour toutes les occasions', 7.50, 2, 30, 'images/fleurs_solo/fleurs2.jpg'),
('Tournesol', 'Un tournesol lumineux pour apporter de la joie', 4.00, 2, 40, 'images/fleurs_solo/fleurs3.jpg'),
('Orchidee Exotique', 'Une orchidee elegante pour un interieur moderne', 12.00, 2, 20, 'images/fleurs_solo/fleurs4.jpg'),

-- Plantes Decoratives
('Plante Grasse', 'Parfaite pour un interieur moderne', 15.00, 3, 20, 'images/plantes_decoratives/plante1.jpg'),
('Fougere Fraiche', 'Une fougere ideale pour une decoration naturelle', 10.00, 3, 25, 'images/plantes_decoratives/plante2.jpg'),
('Bonsai Miniature', 'Un bonsai elegant pour une touche zen', 25.00, 3, 10, 'images/plantes_decoratives/plante3.jpg'),

-- Amour et Romances
('Rose Passion', 'Une rose pour declarer votre amour', 6.00, 4, 25, 'images/occasions/amour_et_romances/amour1.jpg'),
('Bouquet Romantique', 'Un bouquet compose de fleurs rouges et roses', 22.00, 4, 15, 'images/occasions/amour_et_romances/amour2.jpg'),
('Coeur Fleuri', 'Un arrangement en forme de coeur parfait pour la Saint-Valentin', 35.00, 4, 10, 'images/occasions/amour_et_romances/amour3.jpg'),

-- Anniversaire
('Bouquet Anniversaire', 'Un bouquet colore pour celebrer un anniversaire', 18.00, 5, 10, 'images/occasions/anniversaire/anniv1.jpg'),
('Fleurs Joyeuses', 'Des fleurs lumineuses pour une journee speciale', 20.00, 5, 12, 'images/occasions/anniversaire/anniv2.jpg'),
('Panier Fleuri', 'Un panier decoratif pour un cadeau memorable', 28.00, 5, 8, 'images/occasions/anniversaire/anniv3.jpg'),

-- Mariage
('Bouquet de Mariee', 'Un bouquet de mariee raffine pour le grand jour', 30.00, 6, 5, 'images/occasions/mariage/marriage1.jpg'),
('Decor de Table', 'Un arrangement floral pour les tables de mariage', 50.00, 6, 4, 'images/occasions/mariage/marriage2.jfif'),
('Arche Fleurie', 'Une arche decorative pour une ceremonie elegante', 120.00, 6, 2, 'images/occasions/mariage/marriage3.jpg'),

-- Sympathie et Condoleances
('Rose Blanche', 'Une rose blanche pour exprimer vos condoleances', 6.50, 7, 20, 'images/occasions/sympathie_et_condoleances/condo1.jpg'),
('Bouquet Sobre', 'Un bouquet discret pour des moments de recueillement', 18.00, 7, 10, 'images/occasions/sympathie_et_condoleances/condo2.jpg'),
('Lys Blanc Pur', 'Un arrangement de lys pour transmettre votre sympathie', 25.00, 7, 8, 'images/occasions/sympathie_et_condoleances/condo3.jpg');


-- Ajout des utilisateurs
INSERT INTO Utilisateur (nom, email, mot_de_passe, role) VALUES
('Mitia', 'mitia@example.com', 'mitia', 'utilisateur'),
('Admin', 'admin@example.com', 'admin', 'admin');

---------------------------------------
-- Mettre des produits spécifiques en promotion
UPDATE Produit 
SET is_promotion = TRUE 
WHERE nom IN ('Bouquet Joyeux', 'Bouquet Champetre', 'Plante Grasse', 'Bouquet Romantique');

-- Exemple basé sur l'id_produit
UPDATE Produit 
SET is_promotion = TRUE 
WHERE id_produit IN (2, 4, 6, 15);


-- Vérifier les produits en promotion
SELECT * FROM Produit WHERE is_promotion = TRUE;

-- Vérifier les produits sans promotion
SELECT * FROM Produit WHERE is_promotion = FALSE;

-------------------------------
INSERT INTO Ventes (id_utilisateur, id_produit, quantite, montant)
VALUES (1, 101, 3, 60000), (1, 102, 5, 140000), (2, 103, 2, 50000);
