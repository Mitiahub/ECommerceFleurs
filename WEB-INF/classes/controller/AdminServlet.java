package controller;

import dao.CommandeDAO;
import dao.ProduitDAO;
import dao.UtilisateurDAO;
import model.Produit;
import model.Utilisateur;
import model.Commande;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        ProduitDAO produitDAO = new ProduitDAO();
        UtilisateurDAO utilisateurDAO = new UtilisateurDAO();
        CommandeDAO commandeDAO = new CommandeDAO();

        if ("produits".equals(action)) {
            List<Produit> produits = produitDAO.getAllProduits();
            request.setAttribute("produits", produits);
            request.getRequestDispatcher("views/admin/gestionProduits.jsp").forward(request, response);
        } else if ("ajouterProduit".equals(action)) {
            List<String> categories = produitDAO.getAllCategories();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("views/admin/ajouterProduit.jsp").forward(request, response);
        } else if ("modifierProduit".equals(action)) {
            int idProduit = Integer.parseInt(request.getParameter("idProduit"));
            Produit produit = produitDAO.getProduitParId(idProduit);
            List<String> categories = produitDAO.getAllCategories();
            if (produit != null) {
                request.setAttribute("produit", produit);
                request.setAttribute("categories", categories);
                request.getRequestDispatcher("views/admin/modifierProduit.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Produit introuvable");
            }
        } else if ("utilisateurs".equals(action)) {
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
            } else if ("modifierProduit".equals(action)) {
                int idProduit = Integer.parseInt(request.getParameter("idProduit"));
                String nom = request.getParameter("nom");
                String description = request.getParameter("description");
                double prix = Double.parseDouble(request.getParameter("prix"));
                int idCategorie = Integer.parseInt(request.getParameter("idCategorie"));
                int stock = Integer.parseInt(request.getParameter("stock"));
                String image = request.getParameter("image");

                Produit produit = new Produit(idProduit, nom, description, prix, idCategorie, stock, image);
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
