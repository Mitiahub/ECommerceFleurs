<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="fr_FR"/>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion des Promotions</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }

        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: white;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }

        h1 {
            text-align: center;
            color: #228b22;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table th, table td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ddd;
        }

        table th {
            background-color: #228b22;
            color: white;
        }

        button {
            padding: 5px 10px;
            border: none;
            border-radius: 5px;
            background-color: #e63946;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #d62828;
        }

        .add-promotion-button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #228b22;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s, transform 0.3s;
        }

        .add-promotion-button:hover {
            background-color: #1a6f1a;
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Produits en Promotion</h1>
        <div style="text-align: right; margin-bottom: 20px;">
            <a href="admin?action=ajouterPromotion&formulaire=true" class="add-promotion-button">Ajouter une Promotion</a>
        </div>
        <table>
            <thead>
                <tr>
                    <th>Nom</th>
                    <th>Description</th>
                    <th>Prix</th>
                    <th>Reduction (%)</th>
                    <th>Date Debut</th>
                    <th>Date Fin</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                            <c:forEach var="promotion" items="${produitsPromotion}">
                <tr>
                    <td>${promotion.nom}</td>
                    <td>${promotion.description}</td>
                    <td>
                        <!-- Prix Original barré -->
                        <s>${promotion.prix}Ar</s>
                        <br>
                        <!-- Prix Réduit -->
                        ${promotion.prix - (promotion.prix * (promotion.reduction / 100))} Euro
                    </td>
                    <td>${promotion.reduction} %</td>
                    <td>${promotion.dateDebut}</td>
                    <td>${promotion.dateFin}</td>
                    <td>
                        <form action="admin" method="post">
                            <input type="hidden" name="action" value="retirerPromotion">
                            <input type="hidden" name="idProduit" value="${promotion.idProduit}">
                            <button type="submit">Retirer</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>

            </tbody>
        </table>
    </div>
</body>
</html>
