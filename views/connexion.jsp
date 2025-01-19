<!DOCTYPE html>
<html>
<head>
    <title>Connexion - Flora</title>
    <style>
        /* Global styles */
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #83a4d4, #b6fbff); /* Dégradé doux et apaisant */
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            animation: fadeIn 1.5s ease-in-out;
        }

        /* Container styles */
        .container {
            background-color: #fff;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
            text-align: center;
            max-width: 400px;
            width: 100%;
            animation: scaleUp 1s ease-in-out;
        }

        /* Title styles */
        h1 {
            font-size: 2.5em;
            margin-bottom: 20px;
            color: #228b22;
            font-weight: bold;
        }

        /* Form styles */
        form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        label {
            font-weight: bold;
            font-size: 1em;
            text-align: left;
            color: #555;
        }

        input {
            padding: 12px 15px;
            font-size: 1em;
            border: 2px solid #ddd;
            border-radius: 10px;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        input:focus {
            border-color: #228b22;
            box-shadow: 0 4px 15px rgba(34, 139, 34, 0.3);
            outline: none;
        }

        /* Button styles */
        button {
            background-color: #228b22;
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
            background-color: #1a6f1a;
            transform: scale(1.05);
            box-shadow: 0 6px 15px rgba(26, 111, 26, 0.3);
        }

        /* Link styles */
        p {
            margin-top: 15px;
            font-size: 0.9em;
        }

        p a {
            color: #228b22;
            text-decoration: none;
            font-weight: bold;
            transition: color 0.3s, text-decoration 0.3s;
        }

        p a:hover {
            color: #1a6f1a;
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

        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
        }

        /* Additional hover effects */
        button:focus {
            animation: pulse 0.5s ease-in-out;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Connexion</h1>
        <form action="utilisateur" method="post">
            <input type="hidden" name="action" value="connexion">
            <label for="email">Email :</label>
            <input type="email" id="email" name="email" required>
            <label for="motDePasse">Mot de passe :</label>
            <input type="password" id="motDePasse" name="motDePasse" required>
            <button type="submit">Se connecter</button>
        </form>
        <p>Pas encore inscrit ? <a href="utilisateur?action=inscription">S'inscrire</a></p>
    </div>
</body>
</html>
