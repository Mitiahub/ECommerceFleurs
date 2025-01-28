<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Produits en Promotion - Flora</title>
    <meta charset="UTF-8">
    <style>
        /* Global styles */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
            color: #333;
        }

        /* Navbar styles */
               nav {
            background-color: #228b22;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            position: sticky;
            top: 0;
            z-index: 1000;
            animation: fadeIn 1.5s ease-in-out;
        }
        nav .links {
            display: flex;
            align-items: center;
        }
        nav a {
            color: white;
            text-decoration: none;
            margin: 0 15px;
            font-size: 1em;
            font-weight: bold;
            text-transform: uppercase;
            transition: color 0.3s;
        }
        nav a:hover {
            color: #d4d4d4;
        }
        nav .logo {
            font-size: 1.5em;
            font-weight: bold;
            letter-spacing: 1px;
            color: white;
        }
        nav .icons {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        nav .icons img {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            border: 2px solid white;
            transition: border-color 0.3s, transform 0.3s;
            cursor: pointer;
        }
        nav .icons img:hover {
            border-color: #d4d4d4;
            transform: rotate(360deg);
        }
        .btn-deconnexion {
            color: white;
            background-color: #e63946;
            padding: 5px 10px;
            border-radius: 5px;
            text-transform: uppercase;
            text-decoration: none;
            font-size: 0.9em;
            font-weight: bold;
            transition: background-color 0.3s, transform 0.3s;
        }
        .btn-deconnexion:hover {
            background-color: #d62828;
            transform: translateY(-3px);
        }
        /* Content */
        .container {
            max-width: 1200px;
            margin: 50px auto;
            padding: 20px;
            background-color: white;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            text-align: center;
            animation: fadeIn 2s ease-in-out;
        }
        .container h1 {
            font-size: 2em;
            margin-bottom: 20px;
            color: #228b22;
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
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .product-card:hover {
            transform: translateY(-5px) scale(1.05);
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
        .product-card .price {
            font-size: 1.2em;
            font-weight: bold;
            color: #228b22;
            margin: 10px 0;
        }
        .product-card .reduction {
            font-size: 1.2em;
            font-weight: bold;
            color: #e63946;
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
            transition: background-color 0.3s, transform 0.3s;
        }
        .product-card button:hover {
            background-color: #1a6f1a;
            transform: scale(1.05);
        }

        /* Footer */
        footer {
            background-color: #228b22;
            color: white;
            text-align: center;
            padding: 10px 0;
            position: relative;
            margin-top: 20px;
        }

        /* Animations */
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
        <nav>
        <div class="logo">Flora</div>
        <div class="links">
            <a href="${pageContext.request.contextPath}/views/index.jsp">Accueil</a>
            <a href="${pageContext.request.contextPath}/produits">Boutique</a>
            <a href="${pageContext.request.contextPath}/categories">Categories</a>
             <a href="${pageContext.request.contextPath}/promotions">Promotions</a>
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
                <a href="<c:url value='/utilisateur?action=deconnexion' />" class="btn-deconnexion">
                    Deconnexion
                </a>
            </div>
        </div>
    </nav>


    <!-- Container -->
    <div class="container">
        <h1>Produits en Promotion</h1>
        <div class="product-grid">
    <c:forEach var="produit" items="${promotions}">
        <div class="product-card">
            <img src="${produit.image}" alt="${produit.nom}">
            <h2>${produit.nom}</h2>
            <p class="price">
                <s>${produit.prix} Ar</s> <!-- Prix original barré -->
                <br>
                ${produit.prix - (produit.prix * produit.reduction / 100)} € <!-- Prix réduit -->
            </p>
            <p class="reduction">Réduction : ${produit.reduction} %</p>
            <form action="panier" method="post">
                <input type="hidden" name="action" value="ajouter">
                <input type="hidden" name="idProduit" value="${produit.idProduit}">
                <button type="submit">Ajouter au Panier</button>
            </form>
                </div>
            </c:forEach>
        </div>

        <c:if test="${empty promotions}">
            <p>Aucun produit en promotion pour le moment.</p>
        </c:if>
    </div>

    <!-- Footer -->
    <footer>
        <p>2025 Flora. Tous droits réservés.</p>
    </footer>
</body>
</html>
