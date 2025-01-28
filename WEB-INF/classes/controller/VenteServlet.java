package controller;

import dao.VenteDAO;
import model.Vente;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class VenteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        VenteDAO venteDAO = new VenteDAO();

        if ("filtrerParPeriode".equals(action)) {
            try {
                String dateDebutStr = request.getParameter("dateDebut");
                String dateFinStr = request.getParameter("dateFin");

                // Format des dates
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date dateDebut = sdf.parse(dateDebutStr);
                Date dateFin = sdf.parse(dateFinStr);

                // Récupérer les ventes pour la période spécifiée
                List<Vente> ventes = venteDAO.getVentesParPeriode(dateDebut, dateFin);
                request.setAttribute("ventes", ventes);
                request.setAttribute("dateDebut", dateDebutStr);
                request.setAttribute("dateFin", dateFinStr);
                request.getRequestDispatcher("/views/ventes.jsp").forward(request, response);
            } catch (ParseException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Dates invalides.");
            }
        } else if ("utilisateursAvecReduction".equals(action)) {
            double seuilReduction = 200000.0; // Seuil pour la réduction
            List<Integer> utilisateursEligibles = venteDAO.getUtilisateursAvecReduction(seuilReduction);

            // Ajouter les utilisateurs éligibles à la requête
            request.setAttribute("utilisateursEligibles", utilisateursEligibles);
            request.getRequestDispatcher("/views/utilisateursAvecReduction.jsp").forward(request, response);
        } else {
            // Par défaut, afficher toutes les ventes
            List<Vente> ventes = venteDAO.getVentesParPeriode(new Date(0), new Date());
            request.setAttribute("ventes", ventes);
            request.getRequestDispatcher("/views/ventes.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        VenteDAO venteDAO = new VenteDAO();

        if ("appliquerReduction".equals(action)) {
            try {
                int idUtilisateur = Integer.parseInt(request.getParameter("idUtilisateur"));
                double reduction = 0.10; // Réduction de 10%

                boolean reductionAppliquee = venteDAO.appliquerReduction(idUtilisateur, reduction);

                if (reductionAppliquee) {
                    response.sendRedirect(request.getContextPath() + "/ventes?action=utilisateursAvecReduction&message=ReductionAppliquee");
                } else {
                    response.sendRedirect(request.getContextPath() + "/ventes?action=utilisateursAvecReduction&message=Erreur");
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/ventes?action=utilisateursAvecReduction&message=Erreur");
            }
        }
    }
}
