<!DOCTYPE html>
<html>
<head>
    <title>Connexion / Inscription</title>
</head>
<body>
    <h1>Connexion</h1>
    <form action="utilisateur" method="post">
        <input type="hidden" name="action" value="connexion">
        <label for="email">Email :</label>
        <input type="email" name="email" required>
        <label for="mot_de_passe">Mot de passe :</label>
        <input type="password" name="mot_de_passe" required>
        <button type="submit">Se connecter</button>
    </form>

    <h1>Inscription</h1>
    <form action="utilisateur" method="post">
        <input type="hidden" name="action" value="inscription">
        <label for="nom">Nom :</label>
        <input type="text" name="nom" required>
        <label for="email">Email :</label>
        <input type="email" name="email" required>
        <label for="mot_de_passe">Mot de passe :</label>
        <input type="password" name="mot_de_passe" required>
        <button type="submit">S'inscrire</button>
    </form>

    <c:if test="${not empty erreur}">
        <p style="color: red;">${erreur}</p>
    </c:if>
    <c:if test="${not empty message}">
        <p style="color: green;">${message}</p>
    </c:if>
</body>
</html>
