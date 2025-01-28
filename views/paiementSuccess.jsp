<!DOCTYPE html>
<html>
<head>
    <title>Paiement Réussi</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            padding: 20px;
        }
        .message {
            margin: 50px auto;
            padding: 20px;
            border: 2px solid #228b22;
            border-radius: 10px;
            background-color: #f5f5f5;
            color: #228b22;
        }
    </style>
</head>
<body>
    <div class="message">
        <h1>Paiement Reussi</h1>
        <p>Votre commande a ete payee avec succes. Merci pour votre achat !</p>
        <a href="${pageContext.request.contextPath}/commande">Retour a vos commandes</a>
    </div>
</body>
</html>
