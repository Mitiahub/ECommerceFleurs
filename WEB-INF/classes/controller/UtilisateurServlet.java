package controller;

import dao.UtilisateurDAO;
import model.Utilisateur;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class UtilisateurServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        HttpSession session = request.getSession(false); // Récupérer la session existante (sans en créer une nouvelle)
        Utilisateur utilisateur = (session != null) ? (Utilisateur) session.getAttribute("utilisateur") : null;

        if ("connexion".equals(action)) {
            if (utilisateur != null) {
                // Si l'utilisateur est déjà connecté, rediriger vers l'accueil
                response.sendRedirect(request.getContextPath() + "/views/index.jsp");
            } else {
                // Afficher la page de connexion
                request.getRequestDispatcher("/views/connexion.jsp").forward(request, response);
            }
        } else if ("inscription".equals(action)) {
            if (utilisateur != null) {
                // Si l'utilisateur est déjà connecté, rediriger vers l'accueil
                response.sendRedirect(request.getContextPath() + "/views/index.jsp");
            } else {
                // Afficher la page d'inscription
                request.getRequestDispatcher("/views/inscription.jsp").forward(request, response);
            }
        } else if ("deconnexion".equals(action)) {
            if (session != null) {
                // Invalider la session pour déconnecter l'utilisateur
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/views/index.jsp");
        } else {
            // Rediriger vers l'accueil par défaut
            response.sendRedirect(request.getContextPath() + "/views/index.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("connexion".equals(action)) {
            // Connexion de l'utilisateur
            String email = request.getParameter("email");
            String motDePasse = request.getParameter("motDePasse");

            UtilisateurDAO utilisateurDAO = new UtilisateurDAO();
            Utilisateur utilisateur = utilisateurDAO.connexion(email, motDePasse);

            if (utilisateur != null) {
                // Stocker l'utilisateur dans la session
                HttpSession session = request.getSession();
                session.setAttribute("utilisateur", utilisateur);
                response.sendRedirect(request.getContextPath() + "/views/index.jsp");
            } else {
                // Retourner une erreur si l'authentification échoue
                request.setAttribute("erreur", "Email ou mot de passe incorrect.");
                request.getRequestDispatcher("/views/connexion.jsp").forward(request, response);
            }
        } else if ("inscription".equals(action)) {
            // Inscription d'un nouvel utilisateur
            String nom = request.getParameter("nom");
            String email = request.getParameter("email");
            String motDePasse = request.getParameter("motDePasse");

            Utilisateur utilisateur = new Utilisateur();
            utilisateur.setNom(nom);
            utilisateur.setEmail(email);
            utilisateur.setMotDePasse(motDePasse);

            UtilisateurDAO utilisateurDAO = new UtilisateurDAO();
            boolean inscrit = utilisateurDAO.inscription(utilisateur);

            if (inscrit) {
                // Rediriger vers la page de connexion après une inscription réussie
                response.sendRedirect(request.getContextPath() + "/utilisateur?action=connexion");
            } else {
                // Retourner une erreur en cas d'échec de l'inscription
                request.setAttribute("erreur", "Erreur lors de l'inscription. Veuillez réessayer.");
                request.getRequestDispatcher("/views/inscription.jsp").forward(request, response);
            }
        } else if ("deconnexion".equals(action)) {
            // Déconnexion de l'utilisateur
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/views/index.jsp");
        }
    }
}
