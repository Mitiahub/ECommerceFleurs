package controller;

import dao.CategorieDAO;
import dao.ProduitDAO;
import model.Categorie;
import model.Produit;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class CategoriesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CategorieDAO categorieDAO = new CategorieDAO();
        ProduitDAO produitDAO = new ProduitDAO();

        // Récupérer toutes les catégories
        List<Categorie> categories = categorieDAO.getAllCategories();
        request.setAttribute("categories", categories);

        // Vérifier si une catégorie spécifique ou des filtres sont appliqués
        String idCategorieParam = request.getParameter("idCategorie");
        String prixMinParam = request.getParameter("prixMin");
        String prixMaxParam = request.getParameter("prixMax");
        String filterParam = request.getParameter("filter"); // Nouveau paramètre pour les filtres

        int idCategorie = -1; // Valeur par défaut pour aucun filtre sur la catégorie
        double prixMin = 0.0; // Valeur par défaut pour le prix minimum
        double prixMax = Double.MAX_VALUE; // Valeur par défaut pour le prix maximum

        if (idCategorieParam != null && !idCategorieParam.isEmpty()) {
            idCategorie = Integer.parseInt(idCategorieParam);
        }
        if (prixMinParam != null && !prixMinParam.isEmpty()) {
            prixMin = Double.parseDouble(prixMinParam);
        }
        if (prixMaxParam != null && !prixMaxParam.isEmpty()) {
            prixMax = Double.parseDouble(prixMaxParam);
        }

        List<Produit> produits;

        // Gestion des filtres spécifiques
        if ("plantesVertes".equals(filterParam)) {
            produits = produitDAO.getPlantesVertes(); // Méthode spécifique pour "Plantes Vertes"
        } else if ("plantesSensiblesLumiere".equals(filterParam)) {
            produits = produitDAO.getPlantesSensiblesALumiere(); // Méthode spécifique pour "Plantes sensibles à la lumière"
        } else {
            // Récupérer les produits filtrés ou ceux d'une catégorie spécifique
            produits = produitDAO.filtrerProduits(idCategorie, prixMin, prixMax);
        }

        request.setAttribute("produits", produits);

        // Rediriger vers la page des catégories
        request.getRequestDispatcher("views/categories.jsp").forward(request, response);
    }
}
