<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Categories - Flora</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
            color: #333;
        }
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
            transition: transform 0.3s;
        }
        .icons a img:hover {
            transform: rotate(360deg);
        }
        .btn-deconnexion {
            color: white;
            text-decoration: none;
            font-weight: bold;
            margin-left: 10px;
            padding: 5px 10px;
            background-color: #ff4d4d;
            border-radius: 5px;
            transition: background-color 0.3s, transform 0.3s;
        }
        .btn-deconnexion:hover {
            background-color: #cc0000;
            transform: scale(1.1);
        }
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: white;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            animation: fadeIn 1.5s ease-in-out;
        }
        .categories {
            margin-bottom: 20px;
        }
        .categories a {
            display: inline-block;
            margin: 5px;
            padding: 10px 15px;
            background-color: #228b22;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: transform 0.3s, background-color 0.3s;
        }
        .categories a:hover {
            background-color: #1a6f1a;
            transform: scale(1.1);
        }
        .filter-form {
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f9f9f9;
            border-radius: 5px;
            border: 1px solid #ddd;
        }
        .filter-form label {
            margin-right: 10px;
        }
        .filter-form input {
            margin-right: 15px;
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .filter-form button {
            padding: 5px 15px;
            background-color: #228b22;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
        }
        .filter-form button:hover {
            background-color: #1a6f1a;
            transform: scale(1.1);
        }
        .filter-active {
            margin-bottom: 20px;
            font-size: 1.2em;
            color: #228b22;
            font-weight: bold;
        }
        .product-card {
            display: inline-block;
            width: 30%;
            margin: 10px;
            padding: 15px;
            background-color: #fdfdfd;
            border: 1px solid #ddd;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s, background-color 0.3s;
        }
        .product-card:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            background-color: #f1f1f1;
        }
        .product-card img {
            max-width: 100%;
            height: auto;
            max-height: 200px;
            border-radius: 10px;
            margin-bottom: 15px;
            animation: zoomIn 1.2s ease;
        }
        .product-card h2 {
            font-size: 1.5em;
            color: #333;
            margin: 10px 0;
            animation: slideIn 1s ease-out;
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
        .product-card a, .product-card form button {
            display: inline-block;
            margin-top: 10px;
            padding: 8px 15px;
            background-color: #228b22;
            color: white;
            text-decoration: none;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
        }
        .product-card a:hover, .product-card form button:hover {
            background-color: #1a6f1a;
            transform: scale(1.1);
        }
        .product-card form {
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
            animation: fadeIn 1.5s ease-in-out;
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

        @keyframes zoomIn {
            from {
                transform: scale(0.8);
                opacity: 0;
            }
            to {
                transform: scale(1);
                opacity: 1;
            }
        }

        @keyframes slideIn {
            from {
                transform: translateX(-20px);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
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
                <a href="<c:url value='/utilisateur?action=deconnexion' />" class="btn-deconnexion">
                    Deconnexion
                </a>
            </div>
        </div>
    </nav>

    <div class="container">
        <!-- Liste des catégories -->
        <div class="categories">
            <h3>Choisissez une categorie :</h3>
            <c:forEach var="categorie" items="${categories}">
                <a href="${pageContext.request.contextPath}/categories?idCategorie=${categorie.idCategorie}">
                    ${categorie.nom}
                </a>
            </c:forEach>
            <!-- Lien pour les filtres spécifiques -->
            <a href="${pageContext.request.contextPath}/categories?filter=plantesVertes" style="background-color: #2e8b57;">Plantes Vertes</a>
            <a href="${pageContext.request.contextPath}/categories?filter=plantesSensiblesLumiere" style="background-color: #8B0000;">Fleurs Sensibles a la Lumiere</a>
        </div>

            <!-- Indication du filtre actif -->
    <div class="filter-active">
        <c:choose>
            <c:when test="${param.filter == 'plantesVertes'}">
                Affichage des produits : <span style="color: #2e8b57;">Plantes Vertes</span>
            </c:when>
            <c:when test="${param.filter == 'plantesSensiblesLumiere'}">
                Affichage des produits : <span style="color: #8B0000;">Fleurs Sensibles a la Lumiere</span>
            </c:when>
            <c:otherwise>
                <c:if test="${not empty param.idCategorie}">
                    Affichage des produits de la categorie selectionnee.
                </c:if>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Formulaire de filtre -->
    <div class="filter-form">
        <form action="${pageContext.request.contextPath}/categories" method="get">
            <input type="hidden" name="idCategorie" value="${param.idCategorie}">
            <label for="prixMin">Prix Min:</label>
            <input type="number" step="0.01" name="prixMin" id="prixMin" value="${param.prixMin}">
            <label for="prixMax">Prix Max:</label>
            <input type="number" step="0.01" name="prixMax" id="prixMax" value="${param.prixMax}">
            <button type="submit">Filtrer</button>
        </form>
    </div>

    <!-- Liste des produits -->
    <div class="products">
        <c:choose>
            <c:when test="${not empty produits}">
                <c:forEach var="produit" items="${produits}">
                    <div class="product-card">
                        <img src="${produit.image}" alt="${produit.nom}">
                        <h2>${produit.nom}</h2>
                        <p class="price">${produit.prix} Euro</p>
                        <p>${produit.description}</p>
                        <!-- Bouton Voir Produit -->
                        <a href="${pageContext.request.contextPath}/produit?id=${produit.idProduit}" class="btn">Voir Produit</a>
                        <!-- Formulaire Ajouter au Panier -->
                        <form action="${pageContext.request.contextPath}/panier" method="post">
                            <input type="hidden" name="action" value="ajouter">
                            <input type="hidden" name="idProduit" value="${produit.idProduit}">
                            <button type="submit">Ajouter au Panier</button>
                        </form>
                    </div>
                </c:forEach>
            </c:when>
        </c:choose>
    </div>
</div>
<footer>
    <p>2025 Flora. Tous droits reserves.</p>
</footer>

