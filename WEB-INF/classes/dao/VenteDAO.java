package dao;

import model.Vente;
import utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class VenteDAO {

    // Méthode pour enregistrer une vente
    public boolean enregistrerVente(int idUtilisateur, int idProduit, int quantite, double montant) {
        String query = "INSERT INTO Ventes (id_utilisateur, id_produit, quantite, montant, date_vente) VALUES (?, ?, ?, ?, NOW())";
        try (Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, idUtilisateur);
            ps.setInt(2, idProduit);
            ps.setInt(3, quantite);
            ps.setDouble(4, montant);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    // Méthode pour récupérer les ventes par période
    public List<Vente> getVentesParPeriode(Date dateDebut, Date dateFin) {
        String query = "SELECT * FROM Ventes WHERE date_vente BETWEEN ? AND ?";
        List<Vente> ventes = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setTimestamp(1, new Timestamp(dateDebut.getTime()));
            ps.setTimestamp(2, new Timestamp(dateFin.getTime()));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ventes.add(new Vente(
                    rs.getInt("id_vente"),
                    rs.getInt("id_utilisateur"),
                    rs.getInt("id_produit"),
                    rs.getInt("quantite"),
                    rs.getDouble("montant"),
                    rs.getTimestamp("date_vente")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ventes;
    }

    // Méthode pour calculer le total des achats par utilisateur
    public double getTotalAchatsParUtilisateur(int idUtilisateur) {
        String query = "SELECT SUM(montant) AS total FROM Ventes WHERE id_utilisateur = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, idUtilisateur);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    // Méthode pour identifier les utilisateurs éligibles à une réduction
    public List<Integer> getUtilisateursAvecReduction(double seuil) {
        String query = "SELECT id_utilisateur FROM Ventes GROUP BY id_utilisateur HAVING SUM(montant) >= ?";
        List<Integer> utilisateurs = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setDouble(1, seuil);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                utilisateurs.add(rs.getInt("id_utilisateur"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return utilisateurs;
    }

    // Méthode pour récupérer les ventes d'un utilisateur spécifique
    public List<Vente> getVentesParUtilisateur(int idUtilisateur) {
        String query = "SELECT * FROM Ventes WHERE id_utilisateur = ?";
        List<Vente> ventes = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, idUtilisateur);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ventes.add(new Vente(
                    rs.getInt("id_vente"),
                    rs.getInt("id_utilisateur"),
                    rs.getInt("id_produit"),
                    rs.getInt("quantite"),
                    rs.getDouble("montant"),
                    rs.getTimestamp("date_vente")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ventes;
    }

    // Méthode pour appliquer une réduction pour les utilisateurs éligibles
    public boolean appliquerReduction(int idUtilisateur, double reduction) {
        String query = "UPDATE Ventes SET montant = montant * ? WHERE id_utilisateur = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setDouble(1, 1 - reduction); // Réduction en pourcentage
            ps.setInt(2, idUtilisateur);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
