package dao;

import model.Categorie;
import utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategorieDAO {
   public List<Categorie> getAllCategories() {
    List<Categorie> categories = new ArrayList<>();
    String query = "SELECT id_categorie, nom FROM Categories";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(query);
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            categories.add(new Categorie(
                rs.getInt("id_categorie"),
                rs.getString("nom")
            ));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return categories;
}

}
