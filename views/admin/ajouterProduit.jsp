<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ajouter un Produit</title>
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
            max-width: 600px;
            margin: 30px auto;
            padding: 20px;
            background-color: white;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        label {
            font-weight: bold;
            margin-bottom: 5px;
        }
        input, select, textarea, button {
            padding: 10px;
            font-size: 1em;
            border: 1px solid #ddd;
            border-radius: 5px;
            width: 100%;
        }
        textarea {
            resize: none;
        }
        button {
            background-color: #228b22;
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        button:hover {
            background-color: #1a6f1a;
        }
        .form-group {
            display: flex;
            flex-direction: column;
        }
        .form-group input[type="file"] {
            padding: 5px;
        }
    </style>
</head>
<body>
    <h1>Ajouter un Produit</h1>
    <div class="container">
        <form action="admin" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="ajouterProduit">

            <div class="form-group">
                <label for="nom">Nom :</label>
                <input type="text" name="nom" id="nom" required>
            </div>

            <div class="form-group">
                <label for="description">Description :</label>
                <textarea name="description" id="description" rows="4" required></textarea>
            </div>

            <div class="form-group">
                <label for="prix">Prix :</label>
                <input type="number" step="0.01" name="prix" id="prix" required>
            </div>

            <div class="form-group">
                <label for="idCategorie">Categorie :</label>
                <select name="idCategorie" id="idCategorie" required>
                    <option value="">-- Selectionnez une categorie --</option>
                    <c:forEach var="categorie" items="${categories}">
                        <option value="${categorie}">${categorie}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label for="stock">Stock :</label>
                <input type="number" name="stock" id="stock" required>
            </div>

            <div class="form-group">
                <label for="image">Image :</label>
                <input type="file" name="image" id="image" required>
            </div>

            <button type="submit">Ajouter</button>
        </form>
    </div>
</body>
</html>
