<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Modifier un Produit</title>
</head>
<body>
    <h1>Modifier un Produit</h1>
    <form action="<c:url value='/admin' />" method="post">
        <input type="hidden" name="action" value="modifierProduit">
        <input type="hidden" name="idProduit" value="${produit.idProduit}">
        <div>
            <label for="nom">Nom :</label>
            <input type="text" id="nom" name="nom" value="${produit.nom}">
        </div>
        <div>
            <label for="description">Description :</label>
            <textarea id="description" name="description">${produit.description}</textarea>
        </div>
        <div>
            <label for="prix">Prix :</label>
            <input type="number" id="prix" name="prix" step="0.01" value="${produit.prix}">
        </div>
        <div>
            <label for="idCategorie">Catégorie :</label>
            <input type="number" id="idCategorie" name="idCategorie" value="${produit.idCategorie}">
        </div>
        <div>
            <label for="stock">Stock :</label>
            <input type="number" id="stock" name="stock" value="${produit.stock}">
        </div>
        <div>
            <label for="image">Image :</label>
            <input type="text" id="image" name="image" value="${produit.image}">
        </div>
        <button type="submit">Enregistrer</button>
    </form>
</body>
</html>
