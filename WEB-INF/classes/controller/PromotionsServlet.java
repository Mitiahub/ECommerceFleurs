package controller;

import dao.ProduitDAO;
import model.Promotion;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class PromotionsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProduitDAO produitDAO = new ProduitDAO();

        try {
            // Récupérer les promotions
            List<Promotion> promotions = produitDAO.getProduitsEnPromotion();

            if (promotions.isEmpty()) {
                request.setAttribute("message", "Aucun produit en promotion pour le moment.");
            } else {
                request.setAttribute("promotions", promotions);
            }

            // Rediriger vers la page JSP des promotions
            request.getRequestDispatcher("views/promotions.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Une erreur est survenue lors du chargement des promotions.");
            request.getRequestDispatcher("views/promotions.jsp").forward(request, response);
        }
    }
}
