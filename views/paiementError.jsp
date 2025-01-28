<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Erreur de Paiement</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
            color: #333;
            text-align: center;
        }
        .container {
            margin-top: 50px;
        }
        h1 {
            color: #cc0000;
        }
        a {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            padding: 10px 20px;
            background-color: #cc0000;
            color: white;
            border-radius: 5px;
            font-weight: bold;
        }
        a:hover {
            background-color: #a30000;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Erreur lors du paiement</h1>
        <p>Un problème est survenu lors du traitement de votre paiement. Veuillez réessayer.</p>
        <a href="<%= request.getContextPath() %>/commande">Retour à vos commandes</a>
    </div>
</body>
</html>
