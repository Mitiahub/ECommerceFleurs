package controller;

import dao.ProduitDAO;
import model.Produit;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class ProduitDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idProduitParam = request.getParameter("id");
        if (idProduitParam != null && !idProduitParam.isEmpty()) {
            try {
                int idProduit = Integer.parseInt(idProduitParam);

                // Récupérer les informations du produit depuis la base de données
                ProduitDAO produitDAO = new ProduitDAO();
                Produit produit = produitDAO.getProduitParId(idProduit);

                if (produit != null) {
                    request.setAttribute("produit", produit);
                    request.getRequestDispatcher("views/produit.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Produit non trouvé");
                }
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de produit invalide");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de produit manquant");
        }
    }
}
