package dao;

import model.Produit;
import utils.DBConnection;

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
    public void modifierProduit(Produit produit) {
        String query = "UPDATE Produit SET nom = ?, description = ?, prix = ?, id_categorie = ?, stock = ?, image = ? WHERE id_produit = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, produit.getNom());
            ps.setString(2, produit.getDescription());
            ps.setDouble(3, produit.getPrix());
            ps.setInt(4, produit.getIdCategorie());
            ps.setInt(5, produit.getStock());
            ps.setString(6, produit.getImage());
            ps.setInt(7, produit.getIdProduit());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
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
                        rs.getString("image")
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
                        rs.getString("image")
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
                        rs.getString("image")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return produits;
    }
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
    // Méthode pour filtrer les produits
    public List<Produit> filtrerProduits(int idCategorie, double prixMin, double prixMax) {
    List<Produit> produits = new ArrayList<>();
    String query = "SELECT * FROM Produit WHERE (id_categorie = ? OR ? = -1) AND prix BETWEEN ? AND ?";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {
        ps.setInt(1, idCategorie);
        ps.setInt(2, idCategorie);
        ps.setDouble(3, prixMin);
        ps.setDouble(4, prixMax);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            produits.add(new Produit(
                rs.getInt("id_produit"),
                rs.getString("nom"),
                rs.getString("description"),
                rs.getDouble("prix"),
                rs.getInt("id_categorie"),
                rs.getInt("stock"),
                rs.getString("image")
            ));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return produits;
    }

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
                rs.getString("image")
            ));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return plantesVertes;
    
    }

   public List<Produit> getPlantesSensiblesALumiere() {
        String query = "SELECT * FROM Produit WHERE image IN ('images/plantes_decoratives/plante1.jpg', 'images/plantes_decoratives/plante2.jpg', 'images/plantes_decoratives/plante3.jpg')";
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
                        rs.getString("image")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return produits;
    }
}
