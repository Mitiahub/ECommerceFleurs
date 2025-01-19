package controller;

import dao.CommandeDAO;
import dao.ProduitDAO;
import dao.UtilisateurDAO;
import model.Produit;
import model.Utilisateur;
import model.Commande;
import model.Promotion;


import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Date; // Import pour gérer java.sql.Date
import java.util.List;

public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        ProduitDAO produitDAO = new ProduitDAO();
        UtilisateurDAO utilisateurDAO = new UtilisateurDAO();
        CommandeDAO commandeDAO = new CommandeDAO();

        try {
            if ("produits".equals(action)) {
                List<Produit> produits = produitDAO.getAllProduits();
                request.setAttribute("produits", produits);
                request.getRequestDispatcher("views/admin/gestionProduits.jsp").forward(request, response);
            } else if ("ajouterProduit".equals(action)) {
                List<String> categories = produitDAO.getAllCategories();
                request.setAttribute("categories", categories);
                request.getRequestDispatcher("views/admin/ajouterProduit.jsp").forward(request, response);
            } else if ("ajouterPromotion".equals(action) && "true".equals(request.getParameter("formulaire"))) {
                List<Produit> produitsNonEnPromotion = produitDAO.getProduitsNonEnPromotion();
                request.setAttribute("produits", produitsNonEnPromotion);
                request.getRequestDispatcher("views/admin/ajouterPromotion.jsp").forward(request, response);
            }else if ("retirerPromotion".equals(action)) {
            int idProduit = Integer.parseInt(request.getParameter("idProduit"));
            boolean success = produitDAO.retirerProduitDePromotion(idProduit);

            if (success) {
                response.sendRedirect("admin?action=gestionPromotions");
                } else {
                    request.setAttribute("error", "Impossible de retirer le produit de la promotion.");
                    doGet(request, response); // Recharge la page avec un message d'erreur
                }
            }
                 else if ("gestionPromotions".equals(action)) {
                List<Promotion> produitsEnPromotion = produitDAO.getProduitsEnPromotion();
                request.setAttribute("produitsPromotion", produitsEnPromotion);
                request.getRequestDispatcher("views/admin/gestionPromotions.jsp").forward(request, response);
            }

            else if ("utilisateurs".equals(action)) {
                List<Utilisateur> utilisateurs = utilisateurDAO.getAllUtilisateurs();
                request.setAttribute("utilisateurs", utilisateurs);
                request.getRequestDispatcher("views/admin/gestionUtilisateurs.jsp").forward(request, response);
            } else if ("commandes".equals(action)) {
                List<Commande> commandes = commandeDAO.getAllCommandes();
                request.setAttribute("commandes", commandes);
                request.getRequestDispatcher("views/admin/gestionCommandes.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("views/admin/admin.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors du traitement de la demande.");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        ProduitDAO produitDAO = new ProduitDAO();
        CommandeDAO commandeDAO = new CommandeDAO();

        try {
            if ("ajouterProduit".equals(action)) {
                String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }

                Part filePart = request.getPart("image");
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);

                String nom = request.getParameter("nom");
                String description = request.getParameter("description");
                double prix = Double.parseDouble(request.getParameter("prix"));
                int idCategorie = Integer.parseInt(request.getParameter("idCategorie"));
                int stock = Integer.parseInt(request.getParameter("stock"));

                Produit produit = new Produit(nom, description, prix, idCategorie, stock, "images/" + fileName);
                produitDAO.ajouterProduit(produit);
                response.sendRedirect("admin?action=produits");
            } if ("ajouterPromotion".equals(action)) {
                int idProduit = Integer.parseInt(request.getParameter("idProduit"));
                double reduction = Double.parseDouble(request.getParameter("reduction"));
                String dateDebutStr = request.getParameter("dateDebut");
                String dateFinStr = request.getParameter("dateFin");

                if (dateDebutStr != null && dateFinStr != null) {
                    Date sqlDateDebut = Date.valueOf(dateDebutStr);
                    Date sqlDateFin = Date.valueOf(dateFinStr);

                    boolean success = produitDAO.ajouterProduitEnPromotion(idProduit, reduction, sqlDateDebut, sqlDateFin);
                    if (success) {
                        response.sendRedirect("admin?action=gestionPromotions");
                    } else {
                        request.setAttribute("error", "Erreur lors de l'ajout de la promotion.");
                        doGet(request, response); // Recharge la page pour afficher l'erreur
                    }
                } else {
                    request.setAttribute("error", "Les dates de début et de fin sont obligatoires.");
                    doGet(request, response);
                }
            }

                else if ("modifierProduit".equals(action)) {
                int idProduit = Integer.parseInt(request.getParameter("idProduit"));
                String nom = request.getParameter("nom");
                String description = request.getParameter("description");
                double prix = Double.parseDouble(request.getParameter("prix"));
                int idCategorie = Integer.parseInt(request.getParameter("idCategorie"));
                int stock = Integer.parseInt(request.getParameter("stock"));
                String image = request.getParameter("image");

                Produit produit = new Produit(idProduit, nom, description, prix, idCategorie, stock, image, false);
                produitDAO.modifierProduit(produit);
                response.sendRedirect("admin?action=produits");
            } else if ("supprimerProduit".equals(action)) {
                int idProduit = Integer.parseInt(request.getParameter("idProduit"));
                produitDAO.supprimerProduit(idProduit);
                response.sendRedirect("admin?action=produits");
            } else if ("updateCommande".equals(action)) {
                int idCommande = Integer.parseInt(request.getParameter("idCommande"));
                String statut = request.getParameter("statut");

                if (statut != null && (statut.equals("en cours") || statut.equals("livré") || statut.equals("annulé"))) {
                    commandeDAO.updateStatutCommande(idCommande, statut);
                }
                response.sendRedirect("admin?action=commandes");
            } else if ("supprimerCommande".equals(action)) {
                int idCommande = Integer.parseInt(request.getParameter("idCommande"));
                commandeDAO.supprimerCommande(idCommande);
                response.sendRedirect("admin?action=commandes");
            } else {
                doGet(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors du traitement de la demande.");
        }
    }
}
