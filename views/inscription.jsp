<!DOCTYPE html>
<html>
<head>
    <title>Inscription</title>
</head>
<body>
    <h1>Inscription</h1>
    <form action="utilisateur" method="post">
        <input type="hidden" name="action" value="inscription">
        <label for="nom">Nom :</label>
        <input type="text" id="nom" name="nom" required><br>
        <label for="email">Email :</label>
        <input type="email" id="email" name="email" required><br>
        <label for="motDePasse">Mot de passe :</label>
        <input type="password" id="motDePasse" name="motDePasse" required><br>
        <button type="submit">S'inscrire</button>
    </form>
    <p>Deja inscrit ? <a href="utilisateur?action=connexion">Se connecter</a></p>
</body>
</html>
