<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
    <title>Administration - ECommerceFleurs</title>
</head>
<body>
    <h1>Bienvenue dans l'espace administration</h1>
    <nav>
        <a href="admin?action=produits">Gerer les Produits</a>
        <a href="admin?action=utilisateurs">Suivre les Utilisateurs</a>
         <a href="<c:url value='/admin?action=commandes' />">Gerer les Commandes</a>
        <a href="utilisateur?action=deconnexion">Deconnexion</a>
    </nav>
</body>
</html>
