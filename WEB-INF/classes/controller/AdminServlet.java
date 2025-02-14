package controller;

import dao.CommandeDAO;
import dao.ProduitDAO;
import dao.UtilisateurDAO;
import dao.VenteDAO;
import model.Produit;
import model.Utilisateur;
import model.Commande;
import model.Promotion;
import model.CommandeStatut;
import model.Vente;
import model.HistoriquePrix;


import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.List;

public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        ProduitDAO produitDAO = new ProduitDAO();
        UtilisateurDAO utilisateurDAO = new UtilisateurDAO();
        CommandeDAO commandeDAO = new CommandeDAO();
        VenteDAO venteDAO = new VenteDAO();

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
            } else if ("retirerPromotion".equals(action)) {
                int idProduit = Integer.parseInt(request.getParameter("idProduit"));
                boolean success = produitDAO.retirerProduitDePromotion(idProduit);

                if (success) {
                    response.sendRedirect("admin?action=gestionPromotions");
                } else {
                    request.setAttribute("error", "Impossible de retirer le produit de la promotion.");
                    doGet(request, response);
                }
            } else if ("gestionPromotions".equals(action)) {
                List<Promotion> produitsEnPromotion = produitDAO.getProduitsEnPromotion();
                request.setAttribute("produitsPromotion", produitsEnPromotion);
                request.getRequestDispatcher("views/admin/gestionPromotions.jsp").forward(request, response);
            } else if ("gestionVentes".equals(action)) {
                List<Vente> ventes = venteDAO.getVentesParPeriode(new java.util.Date(0), new java.util.Date());
                request.setAttribute("ventes", ventes);
                request.getRequestDispatcher("views/admin/gestionVentes.jsp").forward(request, response);
            }
                else if ("ventes".equals(action)) {
        try {
            // Récupérer toutes les ventes
            List<Vente> ventes = venteDAO.getVentesParPeriode(new java.util.Date(0), new java.util.Date());
            request.setAttribute("ventes", ventes);

            // Rediriger vers la JSP d'affichage des ventes
            request.getRequestDispatcher("views/admin/gestionVentes.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors de la récupération des ventes.");
        }
    }
    else if ("modifierProduit".equals(action)) {
    try {
        int idProduit = Integer.parseInt(request.getParameter("idProduit"));
        Produit produit = produitDAO.getProduitParId(idProduit);
        
        if (produit != null) {
            request.setAttribute("produit", produit);
            request.getRequestDispatcher("views/admin/modifierProduit.jsp").forward(request, response);
        } else {
            response.sendRedirect("admin?action=produits&message=ProduitNonTrouve");
        }
    } catch (NumberFormatException e) {
        e.printStackTrace();
        response.sendRedirect("admin?action=produits&message=ErreurID");
    }
}

            else if ("historiquePrix".equals(action)) {
            try {
                String idProduitStr = request.getParameter("idProduit");

                if (idProduitStr == null || idProduitStr.trim().isEmpty()) {
                    throw new IllegalArgumentException("ID produit manquant.");
                }

                int idProduit = Integer.parseInt(idProduitStr);

                List<HistoriquePrix> historiquePrix = produitDAO.getHistoriquePrix(idProduit);

                request.setAttribute("historiquePrix", historiquePrix);
                request.setAttribute("idProduit", idProduit);  // ✅ Ajout pour éviter erreur JSP
                request.getRequestDispatcher("views/admin/historiquePrix.jsp").forward(request, response);

            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID produit invalide : Format incorrect.");
            } catch (IllegalArgumentException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID produit invalide : " + e.getMessage());
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors de la récupération de l'historique des prix.");
            }
        }

                else if ("filtrerVentes".equals(action)) {
                try {
                    String dateDebutStr = request.getParameter("dateDebut");
                    String dateFinStr = request.getParameter("dateFin");

                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    java.util.Date dateDebut = sdf.parse(dateDebutStr);
                    java.util.Date dateFin = sdf.parse(dateFinStr);

                    List<Vente> ventes = venteDAO.getVentesParPeriode(dateDebut, dateFin);
                    request.setAttribute("ventes", ventes);
                    request.setAttribute("dateDebut", dateDebutStr);
                    request.setAttribute("dateFin", dateFinStr);
                    request.getRequestDispatcher("views/admin/gestionVentes.jsp").forward(request, response);
                } catch (ParseException e) {
                    e.printStackTrace();
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Dates invalides.");
                }
                } else if ("utilisateursAvecReduction".equals(action)) {
                    double seuilReduction = 200000.0;
                    List<Integer> idsUtilisateursEligibles = venteDAO.getUtilisateursAvecReduction(seuilReduction);

                    // Récupérer les objets Utilisateur correspondants à partir des identifiants
                    List<Utilisateur> utilisateursEligibles = utilisateurDAO.getUtilisateursParIds(idsUtilisateursEligibles);

                    request.setAttribute("utilisateursEligibles", utilisateursEligibles);
                    request.getRequestDispatcher("views/admin/utilisateursAvecReduction.jsp").forward(request, response);
                }
                else if ("utilisateurs".equals(action)) {
                List<Utilisateur> utilisateurs = utilisateurDAO.getAllUtilisateurs();
                request.setAttribute("utilisateurs", utilisateurs);
                request.getRequestDispatcher("views/admin/gestionUtilisateurs.jsp").forward(request, response);
            } else if ("commandes".equals(action)) {
                List<Commande> commandes = commandeDAO.getAllCommandes();
                request.setAttribute("commandes", commandes);

                request.setAttribute("statuts", Arrays.asList(
                        CommandeStatut.EN_COURS, 
                        CommandeStatut.LIVRE, 
                        CommandeStatut.ANNULE
                ));
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
        VenteDAO venteDAO = new VenteDAO();

        try {
            if ("ajouterPromotion".equals(action)) {
            try {
                int idProduit = Integer.parseInt(request.getParameter("idProduit"));
                double reduction = Double.parseDouble(request.getParameter("reduction"));
                String dateDebutStr = request.getParameter("dateDebut");
                String dateFinStr = request.getParameter("dateFin");

                if (dateDebutStr != null && dateFinStr != null) {
                    Date sqlDateDebut = Date.valueOf(dateDebutStr);
                    Date sqlDateFin = Date.valueOf(dateFinStr);

                    boolean success = produitDAO.ajouterProduitEnPromotion(idProduit, reduction, sqlDateDebut, sqlDateFin);

                    if (success) {
                        // Redirection vers gestionPromotions
                        response.sendRedirect(request.getContextPath() + "/admin?action=gestionPromotions");
                        return; // Empêche tout code supplémentaire après la redirection
                    } else {
                        // Message d'erreur si l'ajout échoue
                        request.setAttribute("error", "Erreur lors de l'ajout de la promotion.");
                        request.getRequestDispatcher("views/admin/ajouterPromotion.jsp").forward(request, response);
                    }
                } else {
                    // Gestion des dates manquantes
                    request.setAttribute("error", "Les dates de début et de fin sont obligatoires.");
                    request.getRequestDispatcher("views/admin/ajouterPromotion.jsp").forward(request, response);
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Erreur lors du traitement de la promotion.");
                request.getRequestDispatcher("views/admin/ajouterPromotion.jsp").forward(request, response);
            }
        }
            else if ("updateProduit".equals(action)) {
        try {
            int idProduit = Integer.parseInt(request.getParameter("idProduit"));
            String nom = request.getParameter("nom");
            String description = request.getParameter("description");
            double prix = Double.parseDouble(request.getParameter("prix"));
            int idCategorie = Integer.parseInt(request.getParameter("idCategorie"));
            int stock = Integer.parseInt(request.getParameter("stock"));
            String image = request.getParameter("image");

            Produit produit = new Produit(idProduit, nom, description, prix, idCategorie, stock, image, false);
            boolean updateSuccess = produitDAO.modifierProduit(produit);

            if (updateSuccess) {
                // ✅ Si la mise à jour est réussie, redirige vers la liste des produits
                response.sendRedirect("admin?action=produits&message=ProduitModifie");
            }       
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("admin?action=modifierProduit&idProduit=" + request.getParameter("idProduit") + "&message=ErreurID");
        }
    }


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
            } else if ("appliquerReduction".equals(action)) {
                try {
                    int idUtilisateur = Integer.parseInt(request.getParameter("idUtilisateur"));
                    double reduction = 0.10;

                    boolean reductionAppliquee = venteDAO.appliquerReduction(idUtilisateur, reduction);

                    if (reductionAppliquee) {
                        response.sendRedirect("admin?action=utilisateursAvecReduction&message=ReductionAppliquee");
                    } else {
                        response.sendRedirect("admin?action=utilisateursAvecReduction&message=Erreur");
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                    response.sendRedirect("admin?action=utilisateursAvecReduction&message=Erreur");
                }
            }else if ("modifierProduit".equals(action)) {
                    try {
                        int idProduit = Integer.parseInt(request.getParameter("idProduit"));
                        Produit produit = produitDAO.getProduitParId(idProduit);
                        
                        if (produit != null) {
                            request.setAttribute("produit", produit);
                            request.getRequestDispatcher("views/admin/modifierProduit.jsp").forward(request, response);
                        } else {
                            response.sendRedirect("admin?action=produits&message=ProduitNonTrouve");
                        }
                    } catch (NumberFormatException e) {
                        e.printStackTrace();
                        response.sendRedirect("admin?action=produits&message=ErreurID");
                    }
                }
                else if ("supprimerProduit".equals(action)) {
                int idProduit = Integer.parseInt(request.getParameter("idProduit"));
                produitDAO.supprimerProduit(idProduit);
                response.sendRedirect("admin?action=produits");
            } else if ("changerStatutCommande".equals(action)) {
                try {
                    int idCommande = Integer.parseInt(request.getParameter("idCommande"));
                    String statut = request.getParameter("statut");

                    if (statut != null && (statut.equals("en cours") || statut.equals("livré") || statut.equals("annulé"))) {
                        commandeDAO.mettreAJourStatutCommande(idCommande, statut);
                    }
                    response.sendRedirect("admin?action=commandes");
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Erreur lors de la mise à jour de la commande.");
                }
            } else {
                doGet(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors du traitement de la demande.");
        }
    }
}
