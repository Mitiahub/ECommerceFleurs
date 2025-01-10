<!DOCTYPE html>
<html>
<head>
    <title>Connexion</title>
</head>
<body>
    <h1>Connexion</h1>
    <form action="utilisateur" method="post">
        <input type="hidden" name="action" value="connexion">
        <label for="email">Email :</label>
        <input type="email" id="email" name="email" required><br>
        <label for="motDePasse">Mot de passe :</label>
        <input type="password" id="motDePasse" name="motDePasse" required><br>
        <button type="submit">Se connecter</button>
    </form>
    <p>Pas encore inscrit ? <a href="utilisateur?action=inscription">S'inscrire</a></p>
</body>
</html>
