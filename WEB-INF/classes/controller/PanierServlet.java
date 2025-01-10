package controller;

import dao.ProduitDAO;
import model.Produit;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class PanierServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Map<Integer, Integer> panier = getPanierFromSession(session);

        ProduitDAO produitDAO = new ProduitDAO();
        Map<Produit, Integer> produitsPanier = new HashMap<>();
        for (Map.Entry<Integer, Integer> entry : panier.entrySet()) {
            Produit produit = produitDAO.getProduitParId(entry.getKey());
            if (produit != null) {
                produitsPanier.put(produit, entry.getValue());
            }
        }

        request.setAttribute("produitsPanier", produitsPanier);
        request.getRequestDispatcher("views/panier.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Map<Integer, Integer> panier = getPanierFromSession(session);

        if ("ajouter".equals(action)) {
            int idProduit = Integer.parseInt(request.getParameter("idProduit"));
            panier.put(idProduit, panier.getOrDefault(idProduit, 0) + 1);
        } else if ("supprimer".equals(action)) {
            int idProduit = Integer.parseInt(request.getParameter("idProduit"));
            panier.remove(idProduit);
        }

        response.sendRedirect("panier");
    }

    /**
     * Méthode pour récupérer le panier de la session en gérant les conversions.
     *
     * @param session HttpSession de l'utilisateur.
     * @return Map représentant le panier (idProduit -> quantite).
     */
    @SuppressWarnings("unchecked")
    private Map<Integer, Integer> getPanierFromSession(HttpSession session) {
        Object panierObj = session.getAttribute("panier");
        if (panierObj instanceof Map) {
            try {
                return (Map<Integer, Integer>) panierObj;
            } catch (ClassCastException e) {
                e.printStackTrace();
            }
        }
        // Retourne un nouveau panier si aucun n'existe ou si un problème s'est produit
        Map<Integer, Integer> newPanier = new HashMap<>();
        session.setAttribute("panier", newPanier);
        return newPanier;
    }
}
