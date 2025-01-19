package dao;

import model.Commande;
import model.Produit;
import utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CommandeDAO {

    // Obtenir toutes les commandes
    public List<Commande> getAllCommandes() {
        String query = "SELECT c.id_commande, c.date, c.statut, c.id_utilisateur, u.nom AS utilisateur_nom " +
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
                        rs.getString("utilisateur_nom")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return commandes;
    }

    // Mise à jour du statut d'une commande
    public void updateStatutCommande(int idCommande, String statut) {
        String query = "UPDATE Commande SET statut = ? WHERE id_commande = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, statut);
            ps.setInt(2, idCommande);
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Commande mise à jour avec succès : ID = " + idCommande + ", Statut = " + statut);
            } else {
                System.out.println("Aucune commande trouvée pour mise à jour : ID = " + idCommande);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Erreur lors de la mise à jour du statut de la commande : " + e.getMessage());
        }
    }

    // Supprimer une commande
    public void supprimerCommande(int idCommande) {
        String query = "DELETE FROM Commande WHERE id_commande = ?";
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
        String query = "INSERT INTO Commande (id_utilisateur, statut) VALUES (?, 'en cours') RETURNING id_commande";
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

                Commande commande = new Commande(idCommande, date, statut, idUtilisateur, null);

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
                            rsProduits.getBoolean("is_promotion") // Assurez-vous que la colonne `is_promotion` existe
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
}
