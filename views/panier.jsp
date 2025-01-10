<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<!DOCTYPE html>
<html>
<head>
    <title>Votre Panier - ECommerceFleurs</title>
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
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table th, table td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }
        table th {
            background-color: #228b22;
            color: white;
        }
        img {
            max-width: 80px;
            height: auto;
            border-radius: 5px;
        }
        .total {
            font-weight: bold;
            text-align: right;
            margin-top: 20px;
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
            Map<model.Produit, Integer> produitsPanier = (Map<model.Produit, Integer>) request.getAttribute("produitsPanier");
            double total = 0.0;
            if (produitsPanier == null || produitsPanier.isEmpty()) {
        %>
        <p>Votre panier est vide.</p>
        <%
            } else {
        %>
        <table>
            <thead>
                <tr>
                    <th>Image</th>
                    <th>Nom</th>
                    <th>Prix Unitaire</th>
                    <th>Quantité</th>
                    <th>Total</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Map.Entry<model.Produit, Integer> entry : produitsPanier.entrySet()) {
                        model.Produit produit = entry.getKey();
                        int quantite = entry.getValue();
                        double totalProduit = produit.getPrix() * quantite;
                        total += totalProduit;
                %>
                <tr>
                    <td><img src="<%= produit.getImage() %>" alt="<%= produit.getNom() %>"></td>
                    <td><%= produit.getNom() %></td>
                    <td><%= produit.getPrix() %> €</td>
                    <td><%= quantite %></td>
                    <td><%= totalProduit %> €</td>
                    <td>
                        <form action="panier" method="post">
                            <input type="hidden" name="action" value="supprimer">
                            <input type="hidden" name="idProduit" value="<%= produit.getIdProduit() %>">
                            <button type="submit">Supprimer</button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <p class="total">Total : <%= total %> €</p>
        <form action="commande" method="post">
            <button type="submit" style="background-color: #228b22; color: white; padding: 10px 20px; border: none; border-radius: 5px; font-size: 1.2em; cursor: pointer;">Passer la commande</button>
        </form>
        <%
            }
        %>
    </div>
    <footer>
        <p>2025 Flora. Tous droits réservés.</p>
    </footer>
</body>
</html>
