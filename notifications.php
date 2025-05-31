<?php
session_start();
include 'config.php';
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notifications de Négociation - Agora Francia</title>
    <link rel="stylesheet" href="style1.css"> 
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
        }

        td {
            vertical-align: middle;
        }
    </style>
</head>
<body>
<header>
    <h1>Notifications de Négociation - Agora Francia</h1>
</header>
<nav>
    <a href="accueil.php">Accueil</a>
    <a href="toutAfficher.php">Tout Parcourir</a>
    <a href="notifications.php">Notifications</a>

    <?php if (isset($_SESSION['usertype']) && $_SESSION['usertype'] === 'buyer'): ?>
        <a href="panier.php">Panier</a>
    <?php elseif (isset($_SESSION['usertype']) && $_SESSION['usertype'] === 'seller'): ?>
        <a href="offres.php">Mes Offres</a>
    <?php elseif (isset($_SESSION['usertype']) && $_SESSION['usertype'] === 'admin'): ?>
        <a href="gestion.php">Gestion</a>
    <?php endif; ?>

    <?php if (isset($_SESSION['user_id'])): ?>
        <a href="moncompte.php" style="display: inline-block; margin: 0; padding: 0;">
            <img src="<?php echo htmlspecialchars($_SESSION['UserImageURL']); ?>" alt="Image de profil" style="max-width: 120px; max-height: 60px; margin: 0; padding: 0; border: none;"></a>
        <a href="logout.php">Déconnexion</a>
    <?php else: ?>
        <a href="login.html">Se connecter</a>
    <?php endif; ?>
</nav>
<div class="content">

<?php if (isset($_GET['message']) && $_GET['message'] === 'accepted'): ?>
    <div style="background-color: #e6ffed; padding: 10px; border: 1px solid #b2d8b2; margin-bottom: 15px; color: #2d662d;">
        ✅ Offre acceptée avec succès. L’acheteur doit maintenant effectuer le paiement.
    </div>
<?php endif; ?>
<?php if (isset($_GET['message']) && $_GET['message'] === 'countered'): ?>
    <div style="background-color: #e6f3ff; padding: 10px; border: 1px solid #99c9f3; margin-bottom: 15px; color: #1a4c7a;">
        🔁 Contre-offre envoyée avec succès !
    </div>
<?php endif; ?>

<?php
$user_id = $_SESSION['user_id'];
$user_type = $_SESSION['usertype'];

if ($user_type == 'seller') {
    echo "<h2>Offres à traiter sur vos articles</h2>";
    $sql = "SELECT N.NegociationID, A.ArticleName, N.ProposedPrice, N.UserID, N.EtapeNego, N.CreatedAt
            FROM negociations N
            JOIN articles A ON A.ArticleID = N.ArticleID
            WHERE N.Status = 'PendingSeller' AND A.UserID = $user_id
            ORDER BY N.CreatedAt DESC";

    $result = $conn->query($sql);
    if ($result && $result->num_rows > 0) {
        echo "<table><tr><th>Article</th><th>Proposé par</th><th>Prix proposé (€)</th><th>Étape</th><th>Action</th></tr>";
        while ($row = $result->fetch_assoc()) {
            echo "<tr>";
            echo "<td>" . htmlspecialchars($row['ArticleName']) . "</td>";
            echo "<td>Utilisateur ID " . htmlspecialchars($row['UserID']) . "</td>";
            echo "<td>" . htmlspecialchars($row['ProposedPrice']) . "</td>";
            echo "<td>" . htmlspecialchars($row['EtapeNego']) . "</td>";
            echo "<td>
                <form method='post' action='accepter_negociation.php' style='display:inline;'>
                    <input type='hidden' name='negociation_id' value='{$row['NegociationID']}'>
                    <button type='submit'>Accepter</button>
                </form>
                <form method='post' action='refuser_negociation.php' style='display:inline;'>
                    <input type='hidden' name='negociation_id' value='{$row['NegociationID']}'>
                    <button type='submit'>Refuser</button>
                </form>
                <form method='post' action='contre_offre.php' style='display:inline;'>
                    <input type='hidden' name='negociation_id' value='{$row['NegociationID']}'>
                   <input type=\"number\" name=\"proposed_price\" step=\"0.01\" placeholder=\"€\">
                    <button type='submit'>Contre-offre</button>
                </form>
                </td>";
            echo "</tr>";
        }
        echo "</table>";
    } else {
        echo "Aucune offre en attente.";
    }

    // 🔹 Ajout ici : offres déjà acceptées
    echo "<h2>Offres acceptées en attente de paiement</h2>";
    $sql = "SELECT A.ArticleName, N.ProposedPrice, N.EtapeNego, N.CreatedAt
            FROM negociations N
            JOIN articles A ON A.ArticleID = N.ArticleID
            WHERE N.Status = 'Accepted' AND A.UserID = $user_id
            ORDER BY N.CreatedAt DESC";
    $res = $conn->query($sql);
    if ($res && $res->num_rows > 0) {
        echo "<table><tr><th>Article</th><th>Prix accepté (€)</th><th>Étape</th><th>Date</th></tr>";
        while ($row = $res->fetch_assoc()) {
            echo "<tr>";
            echo "<td>" . htmlspecialchars($row['ArticleName']) . "</td>";
            echo "<td>" . htmlspecialchars($row['ProposedPrice']) . "</td>";
            echo "<td>" . htmlspecialchars($row['EtapeNego']) . "</td>";
            echo "<td>" . htmlspecialchars($row['CreatedAt']) . "</td>";
            echo "</tr>";
        }
        echo "</table>";
    } else {
        echo "Aucun paiement en attente.";
    }
}

if ($user_type == 'buyer') {
    echo "<h2>Contre-offres à traiter</h2>";
    $sql_buyer_pending = "SELECT N.NegociationID, A.ArticleName, N.ProposedPrice, N.EtapeNego, N.CreatedAt
                          FROM negociations N
                          JOIN articles A ON A.ArticleID = N.ArticleID
                          WHERE N.Status = 'PendingBuyer' AND N.UserID = $user_id
                          ORDER BY N.CreatedAt DESC";
    $res_buyer = $conn->query($sql_buyer_pending);
    if ($res_buyer && $res_buyer->num_rows > 0) {
        echo "<table><tr><th>Article</th><th>Prix proposé (€)</th><th>Étape</th><th>Date</th><th>Action</th></tr>";
        while ($row = $res_buyer->fetch_assoc()) {
            echo "<tr>";
            echo "<td>" . htmlspecialchars($row['ArticleName']) . "</td>";
            echo "<td>" . htmlspecialchars($row['ProposedPrice']) . "</td>";
            echo "<td>" . htmlspecialchars($row['EtapeNego']) . "</td>";
            echo "<td>" . htmlspecialchars($row['CreatedAt']) . "</td>";
            echo "<td>
                <form method='post' action='accepter_negociation.php' style='display:inline;'>
                    <input type='hidden' name='negociation_id' value='{$row['NegociationID']}'>
                    <button type='submit'>Accepter</button>
                </form>
                <form method='post' action='refuser_negociation.php' style='display:inline;'>
                    <input type='hidden' name='negociation_id' value='{$row['NegociationID']}'>
                    <button type='submit'>Refuser</button>
                </form>
                <form method='post' action='contre_offre.php' style='display:inline;'>
                    <input type='hidden' name='negociation_id' value='{$row['NegociationID']}'>
                    <input type=\"number\" name=\"proposed_price\" step=\"0.01\" placeholder=\"€\">
                    <button type='submit'>Contre-offre</button>
                </form>
            </td>";
            echo "</tr>";
        }
        echo "</table>";
    } else {
        echo "Aucune contre-offre à traiter.";
    }
    


    $sql_nego = "SELECT N.NegociationID, A.ArticleName, N.ProposedPrice, N.Status, N.EtapeNego, N.CreatedAt
                 FROM negociations N
                 JOIN articles A ON A.ArticleID = N.ArticleID
                 WHERE N.UserID = $user_id
                 ORDER BY N.CreatedAt DESC";
    $res_nego = $conn->query($sql_nego);
    if ($res_nego && $res_nego->num_rows > 0) {
        echo "<table><tr><th>Article</th><th>Proposition (€)</th><th>Statut</th><th>Étape</th><th>Date</th></tr>";
        while ($row = $res_nego->fetch_assoc()) {
            echo "<tr>";
            echo "<td>" . htmlspecialchars($row['ArticleName']) . "</td>";
            echo "<td>" . htmlspecialchars($row['ProposedPrice']) . "</td>";
            echo "<td>" . htmlspecialchars($row['Status']) . "</td>";
            echo "<td>" . htmlspecialchars($row['EtapeNego']) . "</td>";
            echo "<td>" . htmlspecialchars($row['CreatedAt']) . "</td>";
            echo "</tr>";
        }
        echo "</table>";
    } else {
        echo "Aucune négociation trouvée.";
    }
}

// Notifications générales
$sql = "SELECT N.NotificationID, N.TypeVente, N.TypeAchat, N.Rarete, N.Quantity, N.CreatedAt, 
        N.Quantity <> IFNULL(NEWARTICLES.ArticleCount, 0) AS QuantityChanged
        FROM notifications N
        LEFT JOIN (
            SELECT TypeVente, Quality, ItemType, COUNT(*) AS ArticleCount
            FROM Articles
            GROUP BY TypeVente, Quality, ItemType
        ) AS NEWARTICLES ON N.TypeVente = NEWARTICLES.TypeVente AND N.TypeAchat = NEWARTICLES.Quality AND N.Rarete = NEWARTICLES.ItemType
        WHERE N.UserID = $user_id";

$result = $conn->query($sql);

if (!$result) {
    echo "Erreur MySQL: " . $conn->error;
} elseif ($result->num_rows > 0) {
    echo "<h2>Notifications de Négociation</h2>";
    echo "<table>";
    echo "<tr><th>Type de Vente</th><th>Type d'Achat</th><th>Rareté</th><th>Quantité</th><th>Date de Création</th><th>Changement de Quantité</th></tr>";

    while ($row = $result->fetch_assoc()) {
        echo "<tr>";
        echo "<td>" . htmlspecialchars($row["TypeVente"]) . "</td>";
        echo "<td>" . htmlspecialchars($row["TypeAchat"]) . "</td>";
        echo "<td>" . htmlspecialchars($row["Rarete"]) . "</td>";
        echo "<td>" . htmlspecialchars($row["Quantity"]) . "</td>";
        echo "<td>" . htmlspecialchars($row["CreatedAt"]) . "</td>";
        echo "<td>" . ($row["QuantityChanged"] ? "Oui" : "Non") . "</td>";
        echo "</tr>";
    }

    echo "</table>";
} else {
    echo "Aucune notification de négociation.";
}
// 🎯 Notifications de victoire aux enchères
$sql_win = "SELECT * FROM Notifications WHERE UserID = $user_id AND TypeVente = 'enchere'";
$result_win = $conn->query($sql_win);

if ($result_win && $result_win->num_rows > 0) {
    echo "<h2>Articles remportés aux enchères</h2>";
    echo "<table><tr><th>Message</th><th>Action</th></tr>";
    while ($row = $result_win->fetch_assoc()) {
        echo "<tr>";
        echo "<td>" . htmlspecialchars($row['Message']) . "</td>";
        echo "<td><a href='panier.php'><button>Procéder au paiement</button></a></td>";
        echo "</tr>";
    }
    echo "</table>";
}

?>
</div>
<div id="footer">
    <p>&copy; 2024 Agora Francia. Tous droits réservés.</p>
    <p>
        <a href="mentions-legales.html">Mentions légales</a> |
        <a href="confidentialite.html">Politique de confidentialité</a> |
        <a href="contact.php">Contact</a>
    </p>
</div>
</body>
</html>
