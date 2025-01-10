<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion des Utilisateurs - ECommerceFleurs</title>
</head>
<body>
    <h1>Gestion des Utilisateurs</h1>
    <table border="1">
        <thead>
            <tr>
                <th>Nom</th>
                <th>Email</th>
                <th>Role</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="utilisateur" items="${utilisateurs}">
                <tr>
                    <td>${utilisateur.nom}</td>
                    <td>${utilisateur.email}</td>
                    <td>${utilisateur.role}</td>
                    <td>
                        <a href="admin?action=supprimerUtilisateur&idUtilisateur=${utilisateur.idUtilisateur}">Supprimer</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
