<?php
session_start();
include 'config.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $article_id = $_POST['article_id'];
    $user_id = $_SESSION['user_id'];
    $proposed_price = $_POST['proposed_price'];
    
    // Vérifie si l'utilisateur a déjà proposé 5 fois
    $sql_etapes = "SELECT COUNT(*) as total FROM Negociations WHERE ArticleID = $article_id AND UserID = $user_id";
    $etapes_result = $conn->query($sql_etapes)->fetch_assoc();
    if ($etapes_result['total'] >= 5) {
        echo "Limite de négociation atteinte (5 maximum).";
    exit();
    }
    $etape = $etapes_result['total'] + 1;

    // Insérer la proposition de négociation dans la table Negociations
    $insert_query = "INSERT INTO Negociations (ArticleID, UserID, ProposedPrice, Status, EtapeNego)
                 VALUES ($article_id, $user_id, $proposed_price, 'PendingSeller', $etape)";

    
    if ($conn->query($insert_query) === TRUE) {
        // Redirection vers la page des notifications
        header("Location: notifications.php");
        exit(); // Assurez-vous de terminer le script après la redirection
    } else {
        echo "Erreur lors de la soumission de la proposition de négociation : " . $conn->error;
    }
    $conn->close();
}
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Négociation - Agora Francia</title>
    <link rel="stylesheet" href="style1.css">
</head>
<body>
    <header>
        <h1>Négociation - Agora Francia</h1>
    </header>
    <nav>
    <a href="accueil.php">Accueil</a>
    <a href="toutAfficher.php">Tout Parcourir</a>
    <a href="#notifications">Notifications</a>

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
        <a href="logout.php">déconnexion</a>

    <?php else: ?>
        <a href="login.html">Se connecter</a>
    <?php endif; ?>
</nav>
    <div class="content">
        <h2>Négociation pour l'article</h2>
        <?php
        // Récupérer l'article depuis la base de données
        $article_id = isset($_GET['article_id']) ? intval($_GET['article_id']) : 0;
        $sql = "SELECT ArticleName, Price FROM Articles WHERE ArticleID = $article_id";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            echo "<p>Nom de l'article : " . $row["ArticleName"] . "</p>";
            echo "<p>Prix de l'article : " . $row["Price"] . "€</p>";
        } else {
            echo "Article non trouvé.";
        }
        ?>
        <form action="negociation.php" method="POST">
            <input type="hidden" name="article_id" value="<?php echo $article_id; ?>">
            <label for="proposed_price">Proposition de prix :</label>
            <input type="number" id="proposed_price" name="proposed_price" step="0.01" min="0" required>
            <button type="submit">Soumettre proposition</button>
        </form>
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