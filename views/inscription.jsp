<!DOCTYPE html>
<html>
<head>
    <title>Inscription - Flora</title>
    <style>
        /* Global styles */
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #FFDEE9, #B5FFFC); /* Dégradé floral doux */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #333;
            animation: fadeIn 1.5s ease-in-out;
        }

        /* Container */
        .container {
            background-color: #fff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
            text-align: center;
            max-width: 400px;
            width: 100%;
            animation: scaleUp 1s ease-in-out;
        }

        /* Title */
        h1 {
            font-size: 2.5em;
            margin-bottom: 20px;
            color: #FF6F91; /* Rose floral */
            font-weight: bold;
        }

        /* Form styles */
        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        label {
            font-weight: bold;
            font-size: 1em;
            text-align: left;
            color: #666;
        }

        input {
            padding: 12px 15px;
            font-size: 1em;
            border: 2px solid #ddd;
            border-radius: 8px;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        input:focus {
            border-color: #FF6F91;
            box-shadow: 0 4px 15px rgba(255, 111, 145, 0.2);
            outline: none;
        }

        /* Button */
        button {
            background-color: #6EC72D; /* Vert floral */
            color: white;
            padding: 12px 15px;
            border: none;
            border-radius: 10px;
            font-size: 1.2em;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s, box-shadow 0.3s;
        }

        button:hover {
            background-color: #57A639;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(87, 166, 57, 0.2);
        }

        /* Link */
        p {
            margin-top: 15px;
            font-size: 0.9em;
            color: #555;
        }

        p a {
            color: #FF6F91;
            text-decoration: none;
            font-weight: bold;
            transition: color 0.3s, text-decoration 0.3s;
        }

        p a:hover {
            color: #FF5775;
            text-decoration: underline;
        }

        /* Animations */
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        @keyframes scaleUp {
            from {
                transform: scale(0.9);
                opacity: 0.8;
            }
            to {
                transform: scale(1);
                opacity: 1;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Inscription</h1>
        <form action="utilisateur" method="post">
            <input type="hidden" name="action" value="inscription">
            <label for="nom">Nom :</label>
            <input type="text" id="nom" name="nom" required>
            <label for="email">Email :</label>
            <input type="email" id="email" name="email" required>
            <label for="motDePasse">Mot de passe :</label>
            <input type="password" id="motDePasse" name="motDePasse" required>
            <button type="submit">S'inscrire</button>
        </form>
        <p>Deja inscrit ? <a href="utilisateur?action=connexion">Se connecter</a></p>
    </div>
</body>
</html>
