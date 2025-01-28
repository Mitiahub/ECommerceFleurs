<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ajouter une Promotion</title>
    <style>
        /* Global styles */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
            color: #333;
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
            background-color: #228b22;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #1a6f1a;
        }
        input[type="number"], input[type="date"] {
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 5px;
            width: 100%;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Ajouter une Promotion</h1>
        <table>
            <thead>
                <tr>
                    <th>Nom</th>
                    <th>Description</th>
                    <th>Prix</th>
                    <th>Réduction (%)</th>
                    <th>Date Début</th>
                    <th>Date Fin</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="produit" items="${produits}">
                    <tr>
                        <td>${produit.nom}</td>
                        <td>${produit.description}</td>
                        <td>${produit.prix} Ar</td>
                        <td>
                            <form action="${pageContext.request.contextPath}/admin" method="post">
                                    <input type="hidden" name="action" value="ajouterPromotion">
                                    <input type="hidden" name="idProduit" value="${produit.idProduit}">
                                    <div class="form-group">
                                        <label for="reduction_${produit.idProduit}">Réduction :</label>
                                        <input type="number" id="reduction_${produit.idProduit}" name="reduction" min="1" max="100" step="0.01" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="dateDebut_${produit.idProduit}">Date Début :</label>
                                        <input type="date" id="dateDebut_${produit.idProduit}" name="dateDebut" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="dateFin_${produit.idProduit}">Date Fin :</label>
                                        <input type="date" id="dateFin_${produit.idProduit}" name="dateFin" required>
                                    </div>
                                    <button type="submit">Ajouter</button>
                                </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <c:if test="${empty produits}">
            <p>Aucun produit disponible pour la promotion.</p>
        </c:if>
    </div>
</body>
</html>
