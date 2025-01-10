package controller;

import dao.ProduitDAO;
import model.Produit;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class ProduitServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProduitDAO produitDAO = new ProduitDAO();
        String action = request.getParameter("action");

        try {
            if ("categorie".equals(action)) {
                int idCategorie = Integer.parseInt(request.getParameter("idCategorie"));
                List<Produit> produits = produitDAO.getProduitsParCategorie(idCategorie);
                request.setAttribute("produits", produits);
            } else if ("details".equals(action)) {
                int idProduit = Integer.parseInt(request.getParameter("idProduit"));
                Produit produit = produitDAO.getProduitParId(idProduit);
                request.setAttribute("produit", produit);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/views/produitDetails.jsp");
                dispatcher.forward(request, response);
                return; // Pour éviter une redirection vers la liste des produits
            } else {
                List<Produit> produits = produitDAO.getAllProduits();
                request.setAttribute("produits", produits);
            }
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/produits.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors de la récupération des produits.");
        }
    }
}
