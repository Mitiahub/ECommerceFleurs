<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion des Produits - ECommerceFleurs</title>
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
            color: #228b22;
            margin-top: 20px;
        }
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: white;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        .add-product {
            display: inline-block;
            margin-bottom: 20px;
            padding: 10px 15px;
            background-color: #228b22;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
        }
        .add-product:hover {
            background-color: #1a6f1a;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table thead {
            background-color: #228b22;
            color: white;
        }
        table th, table td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ddd;
        }
        table th {
            font-weight: bold;
            text-transform: uppercase;
        }
        table tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        table tr:hover {
            background-color: #f1f1f1;
        }
        table img {
            max-width: 100px;
            border-radius: 5px;
        }
        .actions a {
            display: inline-block;
            margin: 5px;
            padding: 5px 10px;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 0.9em;
        }
        .actions a:first-child {
            background-color: #007bff;
        }
        .actions a:first-child:hover {
            background-color: #0056b3;
        }
        .actions a:last-child {
            background-color: #dc3545;
        }
        .actions a:last-child:hover {
            background-color: #a71d2a;
        }
    </style>
</head>
<body>
    <h1>Gestion des Produits</h1>
    <div class="container">
        <a href="admin?action=ajouterProduit" class="add-product">Ajouter un produit</a>
        <table>
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
                        <td>${produit.prix} Euro</td>
                        <td>${produit.idCategorie}</td>
                        <td>${produit.stock}</td>
                        <td>
                            <img src="<c:url value='/${produit.image}' />" alt="${produit.nom}">
                        </td>
                        <td class="actions">
                            <a href="admin?action=modifierProduit&idProduit=${produit.idProduit}">Modifier</a>
                            <a href="admin?action=supprimerProduit&idProduit=${produit.idProduit}">Supprimer</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
