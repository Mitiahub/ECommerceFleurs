<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion des Commandes</title>
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
            margin: 20px 0;
            color: #228b22;
        }
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: white;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table th, table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
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
            margin: 2px;
        }
        button:hover {
            background-color: #1a6f1a;
        }
        .no-commande {
            text-align: center;
            font-size: 1.2em;
            color: #777;
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <h1>Gestion des Commandes</h1>
    <div class="container">
        <c:choose>
            <c:when test="${not empty commandes}">
                <table>
                    <thead>
                        <tr>
                            <th>ID Commande</th>
                            <th>Date</th>
                            <th>Utilisateur</th>
                            <th>Statut</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="commande" items="${commandes}">
                            <tr>
                                <td>${commande.idCommande}</td>
                                <td>${commande.date}</td>
                                <td>${commande.utilisateurNom}</td>
                                <td>${commande.statut}</td>
                                <td>
                                    <form action="admin" method="post">
                                        <input type="hidden" name="action" value="changerStatutCommande">
                                        <input type="hidden" name="idCommande" value="${commande.idCommande}">
                                        <button type="submit" name="statut" value="en cours">En cours</button>
                                        <button type="submit" name="statut" value="livré">Livré</button>
                                        <button type="submit" name="statut" value="annulé">Annulé</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <p class="no-commande">Aucune commande trouvée.</p>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
