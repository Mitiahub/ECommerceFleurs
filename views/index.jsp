<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
    <title>Bienvenue - ECommerceFleurs</title>
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
            transition: border-color 0.3s;
            cursor: pointer;
        }
        nav .icons img:hover {
            border-color: #d4d4d4;
        }

        /* Hero section */
        .hero {
        background-image: url('${pageContext.request.contextPath}/images/hero-banner.jpg');
        background-size: cover;
        background-position: center;
        color: white;
        text-align: center;
        padding: 100px 20px;
    }
        .hero h1 {
            font-size: 3em;
            margin: 0;
        }
        .hero p {
            font-size: 1.5em;
            margin: 10px 0 20px 0;
        }
        .hero a {
            display: inline-block;
            padding: 10px 20px;
            font-size: 1.2em;
            text-decoration: none;
            color: white;
            background-color: #64B5F6;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .hero a:hover {
            background-color: #42A5F5;
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
        }
        .container h2 {
            font-size: 2em;
            margin-bottom: 20px;
        }
        .action-buttons a {
            display: inline-block;
            padding: 10px 20px;
            font-size: 1.2em;
            text-decoration: none;
            color: white;
            background-color: #228b22;
            border-radius: 5px;
            margin: 10px;
            transition: background-color 0.3s;
        }
        .action-buttons a:hover {
            background-color: #1a6f1a;
        }

        /* Footer */
        footer {
            background-color: #228b22;
            color: white;
            text-align: center;
            padding: 10px 0;
            position: relative;
            bottom: 0;
            width: 100%;
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
        transition: background-color 0.3s;
    }

    .btn-deconnexion:hover {
        background-color: #d62828;
    }
    </style>
</head>
<body>
    <!-- Navbar -->
           <!-- Navbar -->
<nav>
    <div class="logo">Flora</div>
    <div class="links">
       <a href="${pageContext.request.contextPath}/views/index.jsp">Accueil</a>
        <a href="${pageContext.request.contextPath}/produits">Boutique</a>
        <a href="${pageContext.request.contextPath}/categories">Categories</a>
        <a href="${pageContext.request.contextPath}/contact">Contact</a>
        <!-- Icons -->
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


    <!-- Hero section -->
    <section class="hero">
        <h1>Bienvenue sur Flora</h1>
        <p>Decouvrez une large selection de fleurs et bouquets pour toutes les occasions.</p>
        <a href="produits">Decouvrir la Boutique</a>
    </section>

    <!-- Content -->
    <div class="container">
        <h2>Pourquoi choisir notre site  ?</h2>
        <p>Notre boutique vous offre des fleurs fraiches, livrees directement chez vous, avec des compositions uniques adaptees a vos envies.</p>
        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/produits">Voir les Produits</a>
            <a href="${pageContext.request.contextPath}/panier">Voir votre Panier</a>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <p>2025 Flora. Tous droits reserves. | <a href="mentions-legales.jsp" style="color: #d4d4d4;">Mentions legales</a></p>
    </footer>
</body>
</html>
