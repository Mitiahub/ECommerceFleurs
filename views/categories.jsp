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
        }
        .categories a:hover {
            background-color: #1a6f1a;
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
        }
        .filter-form button:hover {
            background-color: #1a6f1a;
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
        }
        .product-card img {
            max-width: 100%;
            height: auto;
            max-height: 200px;
            border-radius: 10px;
        }
        .product-card h2 {
            font-size: 1.2em;
            color: #333;
            margin: 10px 0;
        }
        .product-card .price {
            font-size: 1.1em;
            font-weight: bold;
            color: #228b22;
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
        }
        .product-card a:hover, .product-card form button:hover {
            background-color: #1a6f1a;
        }
        .product-card form {
            margin-top: 10px;
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
                <c:otherwise>
                    <p>Aucun produit trouvé pour cette catégorie ou filtre.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
