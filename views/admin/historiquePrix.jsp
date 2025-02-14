<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Historique des Prix</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f5f5f5; }
        .container { max-width: 800px; margin: auto; background: white; padding: 20px; border-radius: 5px; }
        table { width: 100%; border-collapse: collapse; }
        table th, table td { padding: 10px; border: 1px solid #ddd; text-align: center; }
        table th { background-color: #228b22; color: white; }
        .no-data { text-align: center; font-size: 16px; color: #888; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Historique des Prix pour le Produit ID ${idProduit}</h2>

        <table>
            <thead>
                <tr>
                    <th>Ancien Prix</th>
                    <th>Nouveau Prix</th>
                    <th>Date Modification</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="prix" items="${historiquePrix}">
                    <tr>
                        <td>${prix.ancienPrix} Ar</td>
                        <td>${prix.nouveauPrix} Ar</td>
                        <td>${prix.dateModification}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty historiquePrix}">
                    <tr>
                        <td colspan="3" class="no-data">Aucun historique de prix disponible.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <br>
        <a href="admin?action=produits">Retour à la gestion des produits</a>
    </div>
</body>
</html>
