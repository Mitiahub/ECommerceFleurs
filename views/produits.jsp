<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Nos Produits - ECommerceFleurs</title>
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
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }
        .product-card {
            background-color: #fdfdfd;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 15px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .product-card:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        .product-card img {
            max-width: 100%;
            height: auto;
            max-height: 200px;
            object-fit: cover;
            border-radius: 10px;
            margin-bottom: 15px;
        }
        .product-card h2 {
            font-size: 1.5em;
            color: #333;
            margin: 10px 0;
        }
        .product-card p {
            font-size: 0.9em;
            color: #666;
            margin: 10px 0;
        }
        .product-card .price {
            font-size: 1.2em;
            font-weight: bold;
            color: #228b22;
            margin: 10px 0;
        }
        .product-card button {
            background-color: #228b22;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 1em;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .product-card button:hover {
            background-color: #1a6f1a;
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
        <div class="logo">Flora</div>
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
        <div class="product-grid">
            <%
                java.util.List<model.Produit> produits = (java.util.List<model.Produit>) request.getAttribute("produits");
                if (produits != null && !produits.isEmpty()) {
                    for (model.Produit produit : produits) {
            %>
            <div class="product-card">
                <img src="<%= produit.getImage() %>" alt="<%= produit.getNom() %>">
                <h2><%= produit.getNom() %></h2>
                <p class="price"><%= produit.getPrix() %> Euro</p>
                <p><%= produit.getDescription() %></p>
                <form action="panier" method="post">
                    <input type="hidden" name="action" value="ajouter">
                    <input type="hidden" name="idProduit" value="<%= produit.getIdProduit() %>">
                    <button type="submit">Ajouter au panier</button>
                </form>
            </div>
            <% 
                    }
                } else { 
            %>
            <p>Aucun produit disponible pour le moment.</p>
            <% } %>
        </div>
    </div>
    <footer>
        <p>2025 Flora. Tous droits réservés.</p>
    </footer>
</body>
</html>
