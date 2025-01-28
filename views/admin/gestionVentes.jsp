<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion des Ventes - Back Office</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1200px;
            margin: 50px auto;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #228b22;
            margin-bottom: 20px;
        }

        .filter-form {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .filter-form input[type="date"] {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }

        .filter-form button {
            padding: 10px 20px;
            background-color: #228b22;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }

        .filter-form button:hover {
            background-color: #1a6f1a;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table th, table td {
            padding: 12px;
            text-align: center;
            border: 1px solid #ddd;
        }

        table th {
            background-color: #228b22;
            color: white;
        }

        .no-data {
            text-align: center;
            font-size: 16px;
            color: #888;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Gestion des Ventes</h1>
        <form class="filter-form" action="${pageContext.request.contextPath}/admin" method="get">
            <input type="hidden" name="action" value="filtrerVentes">
            <div>
                <label for="dateDebut">Date de début :</label>
                <input type="date" id="dateDebut" name="dateDebut" value="${dateDebut}">
            </div>
            <div>
                <label for="dateFin">Date de fin :</label>
                <input type="date" id="dateFin" name="dateFin" value="${dateFin}">
            </div>
            <div>
                <button type="submit">Filtrer</button>
            </div>
        </form>

        <table>
            <thead>
                <tr>
                    <th>ID Vente</th>
                    <th>ID Utilisateur</th>
                    <th>ID Produit</th>
                    <th>Quantité</th>
                    <th>Montant (Avant Remise)</th>
                    <th>Remise</th>
                    <th>Montant (Final)</th>
                    <th>Date de Vente</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="vente" items="${ventes}">
                    <tr>
                        <td>${vente.idVente}</td>
                        <td>${vente.idUtilisateur}</td>
                        <td>${vente.idProduit}</td>
                        <td>${vente.quantite}</td>
                        <td>${vente.montant} Ar</td>
                        <td>
                            <c:choose>
                                <c:when test="${vente.montant > 200000}">
                                    10 % (${(vente.montant * 0.1)} Ar)
                                </c:when>
                                <c:otherwise>
                                    Pas de remise
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${vente.montant > 200000}">
                                    ${(vente.montant - (vente.montant * 0.1))} Ar
                                </c:when>
                                <c:otherwise>
                                    ${vente.montant} Ar
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${vente.dateVente}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty ventes}">
                    <tr>
                        <td colspan="8" class="no-data">Aucune vente trouvée pour cette période.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</body>
</html>
