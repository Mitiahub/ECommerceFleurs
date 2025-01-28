package controller;

import dao.CommandeDAO;
import dao.ProduitDAO;
import dao.VenteDAO;
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

        String action = request.getParameter("action");
        CommandeDAO commandeDAO = new CommandeDAO();
        ProduitDAO produitDAO = new ProduitDAO();
        VenteDAO venteDAO = new VenteDAO();

        try {
            if ("payerCommande".equals(action)) {
            // Récupérer l'ID de la commande depuis la requête
            int idCommande = Integer.parseInt(request.getParameter("idCommande"));

            // Récupérer les produits de la commande
            Map<Produit, Integer> produitsCommande = commandeDAO.getProduitsParCommande(idCommande);

            // Enregistrer chaque produit de la commande en tant que vente
            for (Map.Entry<Produit, Integer> entry : produitsCommande.entrySet()) {
                Produit produit = entry.getKey();
                int quantite = entry.getValue();
                double montant = produit.getPrix() * quantite;

                // Appliquer une remise si le montant dépasse 200,000 Ar
                double remise = 0;
                if (montant > 200000) {
                    remise = montant * 0.10; // 10 % de remise
                    montant -= remise; // Réduire le montant après remise
                }

                // Ajouter la vente dans la table des ventes
                venteDAO.enregistrerVente(
                    utilisateur.getIdUtilisateur(),
                    produit.getIdProduit(),
                    quantite,
                    montant
                );
            }

            // Supprimer la commande après paiement
            commandeDAO.supprimerCommande(idCommande);

            // Rediriger vers la page de succès
            response.sendRedirect(request.getContextPath() + "/views/paiementSuccess.jsp");
        } 

     else if ("confirmerPaiement".equals(action)) {
                // Confirmation du paiement
                int idCommande = Integer.parseInt(request.getParameter("idCommande"));

                boolean isPaid = commandeDAO.marquerCommandeCommePayee(idCommande);

                if (isPaid) {
                    response.sendRedirect(request.getContextPath() + "/paiementSuccess.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/views/paiementError.jsp");
                }
            } else {
                // Gestion normale des commandes (passer commande)
                Object panierObj = session.getAttribute("panier");
                Map<Integer, Integer> panier = null;

                if (panierObj instanceof Map) {
                    panier = castPanier(panierObj);
                } else {
                    panier = new HashMap<>(); // Initialiser un panier vide si le cast échoue
                }

                if (panier != null && !panier.isEmpty()) {
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
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur interne du serveur.");
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
