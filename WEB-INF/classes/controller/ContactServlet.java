package controller;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class ContactServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Rediriger vers la page de contact
        request.getRequestDispatcher("views/contact.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupérer les données du formulaire de contact
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        // Valider les champs
        if (nom == null || nom.isEmpty() || email == null || email.isEmpty() || message == null || message.isEmpty()) {
            request.setAttribute("erreur", "Tous les champs sont obligatoires.");
            request.getRequestDispatcher("views/contact.jsp").forward(request, response);
            return;
        }

        // Simuler l'envoi du message (vous pouvez ajouter une logique pour envoyer un email ou stocker dans la base de données)
        request.setAttribute("success", "Votre message a été envoyé avec succès.");
        request.getRequestDispatcher("views/contact.jsp").forward(request, response);
    }
}
