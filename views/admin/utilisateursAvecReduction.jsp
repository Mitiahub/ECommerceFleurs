<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Utilisateurs éligibles à une réduction</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 50px auto;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #e63946;
            margin-bottom: 20px;
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
            background-color: #e63946;
            color: white;
        }

        .no-data {
            text-align: center;
            font-size: 16px;
            color: #888;
            margin-top: 20px;
        }

        .apply-discount-form button {
            padding: 8px 12px;
            background-color: #228b22;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }

        .apply-discount-form button:hover {
            background-color: #1a6f1a;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Utilisateurs éligibles à une réduction</h1>
        <table>
            <thead>
                <tr>
                    <th>ID Utilisateur</th>
                    <th>Total Achats (Ar)</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="utilisateur" items="${utilisateursEligibles}">
                    <tr>
                        <td>${utilisateur.idUtilisateur}</td>
                        <td>${utilisateur.totalAchats} Ar</td>
                        <td>
                            <form class="apply-discount-form" action="${pageContext.request.contextPath}/admin" method="post">
                                <input type="hidden" name="action" value="appliquerReduction">
                                <input type="hidden" name="idUtilisateur" value="${utilisateur.idUtilisateur}">
                                <button type="submit">Appliquer 10% de réduction</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty utilisateursEligibles}">
                    <tr>
                        <td colspan="3" class="no-data">Aucun utilisateur éligible à une réduction.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</body>
</html>
