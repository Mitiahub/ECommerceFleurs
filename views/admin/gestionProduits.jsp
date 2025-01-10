<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion des Produits - ECommerceFleurs</title>
</head>
<body>
    <h1>Gestion des Produits</h1>
    <a href="admin?action=ajouterProduit">Ajouter un produit</a>
    <table border="1">
        <thead>
            <tr>
                <th>Nom</th>
                <th>Description</th>
                <th>Prix</th>
                <th>Categorie</th>
                <th>Stock</th>
                <th>Image</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="produit" items="${produits}">
                <tr>
                    <td>${produit.nom}</td>
                    <td>${produit.description}</td>
                    <td>${produit.prix}</td>
                    <td>${produit.idCategorie}</td>
                    <td>${produit.stock}</td>
                    <td>
                        <img src="<c:url value='/${produit.image}' />" alt="${produit.nom}" width="100">
                    </td>
                    <td>
                        <a href="admin?action=modifierProduit&idProduit=${produit.idProduit}">Modifier</a>
                        <a href="admin?action=supprimerProduit&idProduit=${produit.idProduit}">Supprimer</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
