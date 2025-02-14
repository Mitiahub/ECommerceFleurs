package dao;

import model.Produit;
import utils.DBConnection;
import model.Promotion;
import model.HistoriquePrix;



import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProduitDAO {

    // Ajouter un produit
    public void ajouterProduit(Produit produit) {
        String query = "INSERT INTO Produit (nom, description, prix, id_categorie, stock, image) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, produit.getNom());
            ps.setString(2, produit.getDescription());
            ps.setDouble(3, produit.getPrix());
            ps.setInt(4, produit.getIdCategorie());
            ps.setInt(5, produit.getStock());
            ps.setString(6, produit.getImage());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Modifier un produit
    public boolean modifierProduit(Produit produit) {
    String query = "UPDATE produit SET nom = ?, description = ?, prix = ?, id_categorie = ?, stock = ?, image = ? WHERE id_produit = ?";
    
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {

        ps.setString(1, produit.getNom());
        ps.setString(2, produit.getDescription());
        ps.setDouble(3, produit.getPrix());
        ps.setInt(4, produit.getIdCategorie());
        ps.setInt(5, produit.getStock());
        ps.setString(6, produit.getImage());
        ps.setInt(7, produit.getIdProduit());

        int rowsUpdated = ps.executeUpdate();
        return rowsUpdated > 0; // ✅ Retourne vrai si au moins une ligne a été mise à jour

    } catch (SQLException e) {
        e.printStackTrace();
        return false; //  Retourne faux en cas d'erreur
    }
}


    // Supprimer un produit
    public void supprimerProduit(int idProduit) {
        String query = "DELETE FROM Produit WHERE id_produit = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, idProduit);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Obtenir un produit par ID
    public Produit getProduitParId(int idProduit) {
        String query = "SELECT * FROM Produit WHERE id_produit = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, idProduit);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Produit(
                        rs.getInt("id_produit"),
                        rs.getString("nom"),
                        rs.getString("description"),
                        rs.getDouble("prix"),
                        rs.getInt("id_categorie"),
                        rs.getInt("stock"),
                        rs.getString("image"),
                        rs.getBoolean("is_promotion")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Obtenir les produits par catégorie
    public List<Produit> getProduitsParCategorie(int idCategorie) {
        String query = "SELECT * FROM Produit WHERE id_categorie = ?";
        List<Produit> produits = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, idCategorie);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                produits.add(new Produit(
                        rs.getInt("id_produit"),
                        rs.getString("nom"),
                        rs.getString("description"),
                        rs.getDouble("prix"),
                        rs.getInt("id_categorie"),
                        rs.getInt("stock"),
                        rs.getString("image"),
                        rs.getBoolean("is_promotion")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return produits;
    }

    // Obtenir toutes les catégories
    public List<String> getAllCategories() {
        String query = "SELECT nom FROM Categories";
        List<String> categories = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                categories.add(rs.getString("nom"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    // Obtenir tous les produits
    public List<Produit> getAllProduits() {
        String query = "SELECT * FROM Produit";
        List<Produit> produits = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                produits.add(new Produit(
                        rs.getInt("id_produit"),
                        rs.getString("nom"),
                        rs.getString("description"),
                        rs.getDouble("prix"),
                        rs.getInt("id_categorie"),
                        rs.getInt("stock"),
                        rs.getString("image"),
                        rs.getBoolean("is_promotion")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return produits;
    }
    // Filtrer les produits par catégorie et plage de prix
        public List<Produit> filtrerProduits(int idCategorie, double prixMin, double prixMax) {
            String query = "SELECT * FROM Produit WHERE id_categorie = ? AND prix BETWEEN ? AND ?";
            List<Produit> produitsFiltres = new ArrayList<>();
            try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setInt(1, idCategorie);
                ps.setDouble(2, prixMin);
                ps.setDouble(3, prixMax);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    produitsFiltres.add(new Produit(
                            rs.getInt("id_produit"),
                            rs.getString("nom"),
                            rs.getString("description"),
                            rs.getDouble("prix"),
                            rs.getInt("id_categorie"),
                            rs.getInt("stock"),
                            rs.getString("image"),
                            rs.getBoolean("is_promotion")
                    ));
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return produitsFiltres;
        }

    // Ajouter un produit à une commande
    public void ajouterProduitCommande(int idCommande, int idProduit, int quantite) {
        String query = "INSERT INTO Contient (id_commande, id_produit, quantite) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, idCommande);
            ps.setInt(2, idProduit);
            ps.setInt(3, quantite);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


   
    // Obtenir les plantes vertes
        public List<Produit> getPlantesVertes() {
            String query = "SELECT * FROM Produit WHERE is_plante_verte = TRUE";
            List<Produit> plantesVertes = new ArrayList<>();
            try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(query);
                ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    plantesVertes.add(new Produit(
                            rs.getInt("id_produit"),
                            rs.getString("nom"),
                            rs.getString("description"),
                            rs.getDouble("prix"),
                            rs.getInt("id_categorie"),
                            rs.getInt("stock"),
                            rs.getString("image"),
                            rs.getBoolean("is_promotion")
                    ));
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return plantesVertes;
        }

            public List<Produit> getPlantesSensiblesALumiere() {
        // Requête pour récupérer les produits associés à la catégorie "Sensible à la Lumière"
        String query = "SELECT p.* FROM Produit p " +
                    "JOIN Produit_Categories pc ON p.id_produit = pc.id_produit " +
                    "WHERE pc.id_categorie = ?";
        List<Produit> plantesSensibles = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(query)) {
            // ID de la catégorie "Sensible à la Lumière" (par exemple, 8)
            ps.setInt(1, 8);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    plantesSensibles.add(new Produit(
                        rs.getInt("id_produit"),
                        rs.getString("nom"),
                        rs.getString("description"),
                        rs.getDouble("prix"),
                        rs.getInt("id_categorie"), // Catégorie principale
                        rs.getInt("stock"),
                        rs.getString("image"),
                        rs.getBoolean("is_plante_verte") // Vérifiez la colonne correcte dans la base
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return plantesSensibles;
    }

    // Obtenir les produits en promotion
          public List<Promotion> getProduitsEnPromotion() {
    String query = "SELECT p.id_produit, p.nom, p.description, p.prix, p.image, " +
                   "pr.id_promotion, pr.reduction, pr.date_debut, pr.date_fin " +
                   "FROM Produit p " +
                   "JOIN Promotions pr ON p.id_produit = pr.id_produit";
    List<Promotion> promotions = new ArrayList<>();

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(query);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            Promotion promotion = new Promotion(
                rs.getInt("id_promotion"),
                rs.getInt("id_produit"),
                rs.getString("nom"),
                rs.getString("description"),
                rs.getDouble("prix"),
                rs.getDouble("reduction"),
                rs.getDate("date_debut"),
                rs.getDate("date_fin"),
                rs.getString("image") // Ajout de l'image
            );
            promotions.add(promotion);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return promotions;
}

          public List<Produit> getProduitsNonEnPromotion() {
        List<Produit> produits = new ArrayList<>();
        String query = "SELECT * FROM Produit WHERE id_produit NOT IN (SELECT id_produit FROM Promotions)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                produits.add(new Produit(
                        rs.getInt("id_produit"),
                        rs.getString("nom"),
                        rs.getString("description"),
                        rs.getDouble("prix"),
                        rs.getInt("id_categorie"),
                        rs.getInt("stock"),
                        rs.getString("image"),
                        false // Par défaut non en promotion
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return produits;
    }

       public List<Promotion> getAllPromotions() {
        List<Promotion> promotions = new ArrayList<>();
        String query = "SELECT p.id_produit, p.nom, p.description, p.prix, promo.reduction, promo.date_debut, promo.date_fin " +
                       "FROM Produit p " +
                       "JOIN Promotions promo ON p.id_produit = promo.id_produit";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Promotion promotion = new Promotion();
                promotion.setIdProduit(rs.getInt("id_produit"));
                promotion.setNom(rs.getString("nom"));
                promotion.setDescription(rs.getString("description"));
                promotion.setPrix(rs.getDouble("prix"));
                promotion.setReduction(rs.getDouble("reduction"));
                promotion.setDateDebut(rs.getDate("date_debut"));
                promotion.setDateFin(rs.getDate("date_fin"));
                promotions.add(promotion);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return promotions;
    }


        public boolean ajouterProduitEnPromotion(int idProduit, double reduction, Date dateDebut, Date dateFin) {
        String query = "INSERT INTO Promotions (id_produit, reduction, date_debut, date_fin) VALUES (?, ?, ?, ?)";
        try (Connection connection = DBConnection.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, idProduit);
            preparedStatement.setDouble(2, reduction);
            preparedStatement.setDate(3, dateDebut);
            preparedStatement.setDate(4, dateFin);

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0; // Retourne true si une ligne a été insérée
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Retourne false en cas d'erreur
        }
    }
    
        public boolean retirerProduitDePromotion(int idProduit) {
        String query = "DELETE FROM Promotions WHERE id_produit = ?";
        try (Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, idProduit);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; // Retourne true si une ligne a été supprimée
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Retourne false en cas d'erreur
        }
    }
        public boolean mettreAJourPrixProduit(int idProduit, double nouveauPrix) {
        String historiqueQuery = "INSERT INTO historique_prix (id_produit, ancien_prix, nouveau_prix) " +
                                "SELECT id_produit, prix, ? FROM produit WHERE id_produit = ?";
        String updateQuery = "UPDATE produit SET prix = ? WHERE id_produit = ?";

        try (Connection conn = DBConnection.getConnection();
            PreparedStatement psHistorique = conn.prepareStatement(historiqueQuery);
            PreparedStatement psUpdate = conn.prepareStatement(updateQuery)) {

            // Insérer dans historique_prix
            psHistorique.setDouble(1, nouveauPrix);
            psHistorique.setInt(2, idProduit);
            psHistorique.executeUpdate();

            // Mettre à jour le prix du produit
            psUpdate.setDouble(1, nouveauPrix);
            psUpdate.setInt(2, idProduit);
            int rowsUpdated = psUpdate.executeUpdate();

            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

        public List<HistoriquePrix> getHistoriquePrix(int idProduit) {
    List<HistoriquePrix> historique = new ArrayList<>();
    String query = "SELECT id_historique, ancien_prix, nouveau_prix, date_modification FROM historique_prix WHERE id_produit = ? ORDER BY date_modification DESC";

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {

        ps.setInt(1, idProduit);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                historique.add(new HistoriquePrix(
                    rs.getInt("id_historique"),   // Ajout de l'ID historique
                    idProduit,                     // ID du produit
                    rs.getDouble("ancien_prix"),   // Ancien prix
                    rs.getDouble("nouveau_prix"),  // Nouveau prix
                    rs.getTimestamp("date_modification") // Date de modification
                ));
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return historique;
}




}
