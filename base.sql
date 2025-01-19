-- Création de la base de données
CREATE DATABASE fleurs;
\c fleurs;

-- Table Categories (doit être créée avant Produit pour la clé étrangère)
CREATE TABLE Categories (
    id_categorie SERIAL PRIMARY KEY,
    nom VARCHAR(50) UNIQUE NOT NULL
);

-- Table Utilisateur
CREATE TABLE Utilisateur (
    id_utilisateur SERIAL PRIMARY KEY,
    nom VARCHAR(50),
    email VARCHAR(50) UNIQUE,
    mot_de_passe VARCHAR(255),
    role VARCHAR(20) CHECK (role IN ('utilisateur', 'admin')) DEFAULT 'utilisateur'
);

-- Table Produit (catégorie déjà définie dans Categories)
CREATE TABLE Produit (
    id_produit SERIAL PRIMARY KEY,
    nom VARCHAR(50),
    description TEXT,
    prix DECIMAL(10, 2),
    id_categorie INT REFERENCES Categories(id_categorie),
    stock INT CHECK (stock >= 0) DEFAULT 0,
    image VARCHAR(255)
);
ALTER TABLE Produit ADD COLUMN is_plante_verte BOOLEAN DEFAULT FALSE;
UPDATE Produit
SET is_plante_verte = TRUE
WHERE nom IN ('Plante Grasse', 'Fougere Fraiche', 'Bonsai Miniature');

ALTER TABLE Produit
ADD COLUMN is_promotion BOOLEAN DEFAULT FALSE;


-- Table Commande
CREATE TABLE Commande (
    id_commande SERIAL PRIMARY KEY,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_utilisateur INT REFERENCES Utilisateur(id_utilisateur)
);
ALTER TABLE Commande ADD COLUMN statut VARCHAR(20) DEFAULT 'en cours';
ALTER TABLE Commande ADD CONSTRAINT statut_check CHECK (statut IN ('en cours', 'livré', 'annulé'));

CREATE TABLE Archives_Commande (
    id_commande INTEGER PRIMARY KEY,
    date TIMESTAMP,
    id_utilisateur INTEGER,
    statut VARCHAR(20),
    FOREIGN KEY (id_utilisateur) REFERENCES Utilisateur(id_utilisateur)
);


-- Table Contient (Produit et Commande doivent déjà exister)
CREATE TABLE Contient (
    id_commande INT REFERENCES Commande(id_commande),
    id_produit INT REFERENCES Produit(id_produit),
    quantite INT CHECK (quantite > 0),
    PRIMARY KEY (id_commande, id_produit)
);

-- Table Avis (Produit et Utilisateur doivent déjà exister)
CREATE TABLE Avis (
    id_avis SERIAL PRIMARY KEY,
    id_utilisateur INT REFERENCES Utilisateur(id_utilisateur),
    id_produit INT REFERENCES Produit(id_produit),
    note INT CHECK (note BETWEEN 1 AND 5),
    commentaire TEXT,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table Promotions (Produit doit déjà exister)
CREATE TABLE Promotions (
    id_promotion SERIAL PRIMARY KEY,
    id_produit INT REFERENCES Produit(id_produit),
    reduction DECIMAL(5, 2) CHECK (reduction > 0 AND reduction <= 100),
    date_debut TIMESTAMP,
    date_fin TIMESTAMP
);

-- Table Adresse (Utilisateur doit déjà exister)
CREATE TABLE Adresse (
    id_adresse SERIAL PRIMARY KEY,
    id_utilisateur INT REFERENCES Utilisateur(id_utilisateur),
    adresse_ligne1 VARCHAR(255),
    adresse_ligne2 VARCHAR(255),
    ville VARCHAR(50),
    code_postal VARCHAR(10),
    pays VARCHAR(50)
);

-- Table Logs (Utilisateur doit déjà exister)
CREATE TABLE Logs (
    id_log SERIAL PRIMARY KEY,
    action VARCHAR(255),
    id_utilisateur INT REFERENCES Utilisateur(id_utilisateur),
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



