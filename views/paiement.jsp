<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Commande" %>
<!DOCTYPE html>
<html>
<head>
    <title>Paiement</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
            color: #333;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: white;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        h1 {
            text-align: center;
            color: #228b22;
        }
        .details {
            margin-top: 20px;
        }
        .details p {
            margin: 5px 0;
        }
        .btn-pay {
            display: block;
            margin: 20px auto;
            background-color: #228b22;
            color: white;
            text-align: center;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 1.2em;
            cursor: pointer;
            text-decoration: none;
        }
        .btn-pay:hover {
            background-color: #1a6f1a;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Paiement</h1>
        <%
            Commande commande = (Commande) request.getAttribute("commande");
            if (commande == null) {
        %>
        <p>Erreur : commande non trouvée.</p>
        <%
            } else {
        %>
        <div class="details">
            <p>Commande ID : <%= commande.getIdCommande() %></p>
            <p>Montant total : <strong><%= request.getAttribute("totalCommande") %> €</strong></p>
        </div>
        <form action="${pageContext.request.contextPath}/views/paiementSuccess.jsp" method="get">
            <input type="hidden" name="idCommande" value="<%= commande.getIdCommande() %>">
            <button type="submit">Confirmer et Payer</button>
        </form>
        <% } %>
    </div>
</body>
</html>
