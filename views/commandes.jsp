<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.Commande" %>
<%@ page import="model.Produit" %>
<!DOCTYPE html>
<html>
<head>
    <title>Vos Commandes - ECommerceFleurs</title>
    <meta charset="UTF-8">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
            color: #333;
        }
        nav {
            background-color: #228b22;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
        }
        .logo {
            font-size: 1.8em;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 2px;
        }
        .links {
            display: flex;
            align-items: center;
        }
        .links a {
            color: white;
            text-decoration: none;
            margin-right: 15px;
            font-size: 1em;
            transition: color 0.3s;
        }
        .links a:hover {
            color: #ffcc00;
        }
        .icons a img {
            width: 25px;
            height: 25px;
            margin-left: 10px;
            cursor: pointer;
        }
        .btn-deconnexion {
            color: white;
            text-decoration: none;
            font-weight: bold;
            margin-left: 10px;
            padding: 5px 10px;
            background-color: #ff4d4d;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .btn-deconnexion:hover {
            background-color: #cc0000;
        }
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: white;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        .commande {
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 15px;
            background-color: #fdfdfd;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .commande h2 {
            font-size: 1.5em;
            margin-bottom: 10px;
            color: #333;
        }
        .commande table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        .commande table th, .commande table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        .commande table th {
            background-color: #228b22;
            color: white;
        }
        .commande table td img {
            max-width: 50px;
            height: auto;
            border-radius: 5px;
        }
        .commande .statut {
            font-weight: bold;
            color: #228b22;
            margin-top: 10px;
        }
        footer {
            background-color: #228b22;
            color: white;
            text-align: center;
            padding: 10px 0;
            position: relative;
            margin-top: 20px;
            bottom: 0;
            width: 100%;
        }
    </style>
</head>
<body>
    <nav>
        <div class="logo">Fleurs</div>
        <div class="links">
            <a href="${pageContext.request.contextPath}/views/index.jsp">Accueil</a>
            <a href="${pageContext.request.contextPath}/produits">Boutique</a>
            <a href="${pageContext.request.contextPath}/categories">Categories</a>
            <a href="${pageContext.request.contextPath}/contact">Contact</a>
            <div class="icons">
                <a href="${pageContext.request.contextPath}/panier">
                    <img src="${pageContext.request.contextPath}/images/panier.png" alt="Panier">
                </a>
                <a href="${pageContext.request.contextPath}/utilisateur?action=connexion">
                    <img src="${pageContext.request.contextPath}/images/profile.png" alt="Connexion">
                </a>
                <a href="${pageContext.request.contextPath}/admin">
                    <img src="${pageContext.request.contextPath}/images/admin.png" alt="Admin">
                </a>
                <a href="<c:url value='/utilisateur?action=deconnexion' />" class="btn-deconnexion">Deconnexion</a>
            </div>
        </div>
    </nav>
    <div class="container">
        <%
            Map<Commande, Map<Produit, Integer>> commandes = 
                (Map<Commande, Map<Produit, Integer>>) request.getAttribute("commandes");
            if (commandes == null || commandes.isEmpty()) {
        %>
        <p>Aucune commande trouvée.</p>
        <%
            } else {
                for (Map.Entry<Commande, Map<Produit, Integer>> entry : commandes.entrySet()) {
                    Commande commande = entry.getKey();
                    Map<Produit, Integer> produits = entry.getValue();
        %>
        <div class="commande">
            <h2>Commande #<%= commande.getIdCommande() %></h2>
            <p>Date : <%= commande.getDate() %></p>
            <p class="statut">Statut : <%= commande.getStatut() %></p>
            <table>
                <thead>
                    <tr>
                        <th>Image</th>
                        <th>Produit</th>
                        <th>Prix Unitaire</th>
                        <th>Quantité</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        double totalCommande = 0;
                        for (Map.Entry<Produit, Integer> produitEntry : produits.entrySet()) {
                            Produit produit = produitEntry.getKey();
                            int quantite = produitEntry.getValue();
                            double totalProduit = produit.getPrix() * quantite;
                            totalCommande += totalProduit;
                    %>
                    <tr>
                        <td><img src="<%= produit.getImage() %>" alt="<%= produit.getNom() %>"></td>
                        <td><%= produit.getNom() %></td>
                        <td><%= produit.getPrix() %> €</td>
                        <td><%= quantite %></td>
                        <td><%= totalProduit %> €</td>
                    </tr>
                    <% } %>
                    <tr>
                        <td colspan="4" style="text-align: right; font-weight: bold;">Total de la commande :</td>
                        <td><%= totalCommande %> €</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <% 
                }
            } 
        %>
    </div>
    <footer>
        <p>2025 Flora. Tous droits réservés.</p>
    </footer>
</body>
</html>
