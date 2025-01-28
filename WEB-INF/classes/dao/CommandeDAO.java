package dao;

import model.Commande;
import model.Produit;
import utils.DBConnection;
import dao.VenteDAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CommandeDAO {

    // Obtenir toutes les commandes
    public List<Commande> getAllCommandes() {
        String query = "SELECT c.id_commande, c.date, c.statut, c.id_utilisateur, u.nom AS utilisateur_nom, c.paiement " +
                       "FROM Commande c " +
                       "JOIN Utilisateur u ON c.id_utilisateur = u.id_utilisateur";
        List<Commande> commandes = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                commandes.add(new Commande(
                        rs.getInt("id_commande"),
                        rs.getTimestamp("date"),
                        rs.getString("statut"),
                        rs.getInt("id_utilisateur"),
                        rs.getString("utilisateur_nom"),
                        rs.getBoolean("paiement")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return commandes;
    }

    // Méthode pour mettre à jour le statut de la commande
    public boolean mettreAJourStatutCommande(int idCommande, String nouveauStatut) {
        String query = "UPDATE commande SET statut = ? WHERE id_commande = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, nouveauStatut);
            ps.setInt(2, idCommande);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void supprimerCommande(int idCommande) {
        String query = "DELETE FROM Commandes WHERE id_commande = ?";
        try (Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, idCommande);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    // Créer une commande
    public int creerCommande(int idUtilisateur) {
        String query = "INSERT INTO Commande (id_utilisateur, statut, paiement) VALUES (?, 'en cours', false) RETURNING id_commande";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, idUtilisateur);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("id_commande");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Retourne -1 si la création de la commande échoue
    }

    // Obtenir les commandes et leurs produits par utilisateur
    public Map<Commande, Map<Produit, Integer>> getCommandesParUtilisateur(int idUtilisateur) {
        String queryCommandes = "SELECT * FROM Commande WHERE id_utilisateur = ?";
        String queryProduits = "SELECT p.*, c.quantite FROM Contient c " +
                               "JOIN Produit p ON c.id_produit = p.id_produit " +
                               "WHERE c.id_commande = ?";
        Map<Commande, Map<Produit, Integer>> commandes = new HashMap<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement psCommandes = conn.prepareStatement(queryCommandes)) {
            psCommandes.setInt(1, idUtilisateur);
            ResultSet rsCommandes = psCommandes.executeQuery();

            while (rsCommandes.next()) {
                int idCommande = rsCommandes.getInt("id_commande");
                Timestamp date = rsCommandes.getTimestamp("date");
                String statut = rsCommandes.getString("statut");
                boolean paiement = rsCommandes.getBoolean("paiement");

                Commande commande = new Commande(idCommande, date, statut, idUtilisateur, null, paiement);

                // Récupérer les produits associés à cette commande
                Map<Produit, Integer> produits = new HashMap<>();
                try (PreparedStatement psProduits = conn.prepareStatement(queryProduits)) {
                    psProduits.setInt(1, idCommande);
                    ResultSet rsProduits = psProduits.executeQuery();

                    while (rsProduits.next()) {
                        Produit produit = new Produit(
                            rsProduits.getInt("id_produit"),
                            rsProduits.getString("nom"),
                            rsProduits.getString("description"),
                            rsProduits.getDouble("prix"),
                            rsProduits.getInt("id_categorie"),
                            rsProduits.getInt("stock"),
                            rsProduits.getString("image"),
                            rsProduits.getBoolean("is_promotion")
                        );

                        int quantite = rsProduits.getInt("quantite");
                        produits.put(produit, quantite);
                    }
                }

                commandes.put(commande, produits);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return commandes;
    }

            public Commande getCommandeById(int idCommande) {
            String query = "SELECT c.id_commande, c.date, c.statut, c.id_utilisateur, u.nom AS utilisateur_nom, c.paiement " +
                        "FROM Commande c " +
                        "JOIN Utilisateur u ON c.id_utilisateur = u.id_utilisateur " +
                        "WHERE c.id_commande = ?";
            try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setInt(1, idCommande);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    return new Commande(
                        rs.getInt("id_commande"),
                        rs.getTimestamp("date"),
                        rs.getString("statut"),
                        rs.getInt("id_utilisateur"),
                        rs.getString("utilisateur_nom"),
                        rs.getBoolean("paiement")
                    );
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return null; // Retourne null si la commande n'est pas trouvée
        }

                public boolean marquerCommandeCommePayee(int idCommande) {
            String query = "UPDATE Commande SET paiement = true, statut = 'en cours' WHERE id_commande = ?";
            try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setInt(1, idCommande);

                int rowsAffected = ps.executeUpdate();
                return rowsAffected > 0; // Retourne true si une ligne a été mise à jour
            } catch (SQLException e) {
                e.printStackTrace();
                return false; // Retourne false en cas d'erreur
            }
        }

            public boolean estCommandePayee(int idCommande) {
        String query = "SELECT paiement FROM Commande WHERE id_commande = ?";
        try (Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, idCommande);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getBoolean("paiement");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Retourne false si la commande n'est pas payée ou si une erreur survient
    }

        public double getTotalCommande(int idCommande) {
        String query = "SELECT SUM(p.prix * c.quantite) AS total FROM Contient c " +
                    "JOIN Produit p ON c.id_produit = p.id_produit " +
                    "WHERE c.id_commande = ?";
        try (Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, idCommande);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("total");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0; // Retourne 0 si une erreur se produit
    }

        public boolean mettreAJourStatutPaiement(int idCommande) {
        String query = "UPDATE Commande SET paiement = true WHERE id_commande = ?";
        try (Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, idCommande);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; // Retourne true si au moins une ligne est mise à jour
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Retourne false en cas d'erreur
    }

            public Map<Produit, Integer> getProduitsParCommande(int idCommande) {
        String query = "SELECT p.id_produit, p.nom, p.description, p.prix, p.image, c.quantite " +
                    "FROM produit p " +
                    "JOIN contient c ON p.id_produit = c.id_produit " +
                    "WHERE c.id_commande = ?";
        Map<Produit, Integer> produitsCommande = new HashMap<>();

        try (Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, idCommande);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Produit produit = new Produit(
                    rs.getInt("id_produit"),
                    rs.getString("nom"),
                    rs.getString("description"),
                    rs.getDouble("prix"),
                    rs.getString("image")
                );
                int quantite = rs.getInt("quantite");
                produitsCommande.put(produit, quantite);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Erreur lors de la récupération des produits de la commande : " + e.getMessage());
        }
        return produitsCommande;
    }

    public boolean ajouterProduitCommande(int idCommande, int idProduit, int quantite) {
    String query = "INSERT INTO contient (id_commande, id_produit, quantite) VALUES (?, ?, ?)";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {

        ps.setInt(1, idCommande);
        ps.setInt(2, idProduit);
        ps.setInt(3, quantite);
        ps.executeUpdate();
        return true;
    } catch (SQLException e) {
        e.printStackTrace();
        System.out.println("Erreur lors de l'ajout du produit à la commande : " + e.getMessage());
        return false;
    }
}


}   
