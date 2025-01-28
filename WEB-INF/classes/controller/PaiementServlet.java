package controller;

import dao.CommandeDAO;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class PaiementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Récupérer les informations de la commande
            int idCommande = Integer.parseInt(request.getParameter("idCommande"));
            double totalCommande = Double.parseDouble(request.getParameter("totalCommande"));

            // Ajouter les informations à la requête
            request.setAttribute("idCommande", idCommande);
            request.setAttribute("totalCommande", totalCommande);

            // Rediriger vers la page de paiement
            request.getRequestDispatcher("/views/paiement.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/views/paiementError.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Récupérer l'ID de la commande
            int idCommande = Integer.parseInt(request.getParameter("idCommande"));

            // Marquer la commande comme payée
            CommandeDAO commandeDAO = new CommandeDAO();
            boolean paiementReussi = commandeDAO.marquerCommandeCommePayee(idCommande);

            // Rediriger en fonction du résultat
            if (paiementReussi) {
                response.sendRedirect(request.getContextPath() + "/views/paiementSuccess.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/views/paiementError.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/views/paiementError.jsp");
        }
    }
}
