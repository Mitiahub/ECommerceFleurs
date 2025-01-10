<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ajouter un Produit</title>
</head>
<body>
    <h1>Ajouter un Produit</h1>
    <form action="admin" method="post" enctype="multipart/form-data">
        <input type="hidden" name="action" value="ajouterProduit">

        <label for="nom">Nom :</label>
        <input type="text" name="nom" id="nom" required><br>

        <label for="description">Description :</label>
        <textarea name="description" id="description" required></textarea><br>

        <label for="prix">Prix :</label>
        <input type="number" step="0.01" name="prix" id="prix" required><br>

        <label for="idCategorie">Categorie :</label>
        <select name="idCategorie" id="idCategorie" required>
            <option value="">-- Selectionnez une categorie --</option>
            <c:forEach var="categorie" items="${categories}">
                <option value="${categorie}">${categorie}</option>
            </c:forEach>
        </select><br>

        <label for="stock">Stock :</label>
        <input type="number" name="stock" id="stock" required><br>

        <label for="image">Image :</label>
        <input type="file" name="image" id="image" required><br>

        <button type="submit">Ajouter</button>
    </form>
</body>
</html>
