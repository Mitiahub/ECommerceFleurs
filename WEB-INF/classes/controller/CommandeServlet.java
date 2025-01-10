package controller;

import dao.CommandeDAO;
import dao.ProduitDAO;
import model.Commande;
import model.Produit;
import model.Utilisateur;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class CommandeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Vérifier si l'utilisateur est connecté
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        if (utilisateur == null) {
            // Rediriger vers la page de connexion si l'utilisateur n'est pas connecté
            response.sendRedirect(request.getContextPath() + "/utilisateur?action=connexion");
            return;
        }

        // Récupérer le panier de l'utilisateur
        Object panierObj = session.getAttribute("panier");
        Map<Integer, Integer> panier = null;

        if (panierObj instanceof Map) {
            panier = castPanier(panierObj);
        } else {
            panier = new HashMap<>(); // Initialiser un panier vide si le cast échoue
        }

        if (panier != null && !panier.isEmpty()) {
            CommandeDAO commandeDAO = new CommandeDAO();
            ProduitDAO produitDAO = new ProduitDAO();

            // Créer une commande et récupérer son ID
            int idCommande = commandeDAO.creerCommande(utilisateur.getIdUtilisateur());

            if (idCommande != -1) {
                // Ajouter chaque produit du panier à la commande
                for (Map.Entry<Integer, Integer> entry : panier.entrySet()) {
                    int idProduit = entry.getKey();
                    int quantite = entry.getValue();
                    produitDAO.ajouterProduitCommande(idCommande, idProduit, quantite);
                }

                // Vider le panier après la commande
                session.removeAttribute("panier");

                // Rediriger vers la liste des commandes avec un succès
                response.sendRedirect(request.getContextPath() + "/commande");
            } else {
                // Erreur lors de la création de la commande
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors de la création de la commande.");
            }
        } else {
            // Rediriger vers la page du panier si le panier est vide
            response.sendRedirect(request.getContextPath() + "/panier");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Gérer les commandes pour l'utilisateur connecté
        HttpSession session = request.getSession();
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");

        if (utilisateur == null) {
            // Rediriger vers la page de connexion si non connecté
            response.sendRedirect(request.getContextPath() + "/utilisateur?action=connexion");
            return;
        }

        CommandeDAO commandeDAO = new CommandeDAO();
        Map<Commande, Map<Produit, Integer>> commandes = commandeDAO.getCommandesParUtilisateur(utilisateur.getIdUtilisateur());

        request.setAttribute("commandes", commandes);
        request.getRequestDispatcher("/views/commandes.jsp").forward(request, response);
    }

    @SuppressWarnings("unchecked")
    private Map<Integer, Integer> castPanier(Object panierObj) {
        try {
            return (Map<Integer, Integer>) panierObj;
        } catch (ClassCastException e) {
            e.printStackTrace();
            return new HashMap<>();
        }
    }
}
