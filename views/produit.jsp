<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Details du Produit</title>
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
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: white;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            text-align: center;
        }
        img {
            max-width: 100%;
            height: auto;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .product-info h1 {
            font-size: 2em;
            margin: 10px 0;
        }
        .product-info p {
            margin: 10px 0;
        }
        .product-info .price {
            font-size: 1.5em;
            font-weight: bold;
            color: #228b22;
        }
        .actions button {
            padding: 10px 20px;
            background-color: #228b22;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 1em;
            cursor: pointer;
            margin-top: 20px;
        }
        .actions button:hover {
            background-color: #1a6f1a;
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
        <c:choose>
            <c:when test="${not empty produit}">
                <div class="product-info">
                    <img src="${produit.image}" alt="${produit.nom}">
                    <h1>${produit.nom}</h1>
                    <p class="price">${produit.prix} Euro</p>
                    <p>${produit.description}</p>
                </div>
                <div class="actions">
                    <form action="${pageContext.request.contextPath}/panier" method="post">
                        <input type="hidden" name="action" value="ajouter">
                        <input type="hidden" name="idProduit" value="${produit.idProduit}">
                        <button type="submit">Ajouter au Panier</button>
                    </form>
                </div>
            </c:when>
            <c:otherwise>
                <p>Produit non trouvé.</p>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
