<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
    <title>Administration - ECommerceFleurs</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
            color: #333;
        }
        h1 {
            text-align: center;
            margin: 20px 0;
            color: #228b22;
        }
        nav {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 20px;
        }
        nav a {
            display: flex;
            align-items: center;
            text-decoration: none;
            color: #333;
            font-size: 1.2em;
            font-weight: bold;
            padding: 10px 15px;
            background-color: #fdfdfd;
            border: 1px solid #ddd;
            border-radius: 10px;
            margin: 10px 0;
            width: 250px;
            justify-content: center;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s, box-shadow 0.3s;
        }
        nav a:hover {
            background-color: #228b22;
            color: white;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
        }
        nav a img {
            width: 25px;
            height: 25px;
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <h1>Bienvenue dans l'espace administration</h1>
    <nav>
    <a href="admin?action=produits">
        <img src="${pageContext.request.contextPath}/images/box.png" alt="Gerer les Produits">
        Gerer les Produits
    </a>
    <a href="admin?action=utilisateurs">
        <img src="${pageContext.request.contextPath}/images/user.png" alt="Suivre les Utilisateurs">
        Suivre les Utilisateurs
    </a>
    <a href="<c:url value='/admin?action=commandes' />">
        <img src="${pageContext.request.contextPath}/images/checklist.png" alt="Gerer les Commandes">
        Gerer les Commandes
    </a>
    <a href="<c:url value='/admin?action=gestionPromotions' />">
        <img src="${pageContext.request.contextPath}/images/promotion.png" alt="Gerer les Promotions">
        Gerer les Promotions
    </a>
    <a href="utilisateur?action=deconnexion">
        <img src="${pageContext.request.contextPath}/images/deconnexion.png" alt="Deconnexion">
        Deconnexion
    </a>
</nav>

</body>
</html>
