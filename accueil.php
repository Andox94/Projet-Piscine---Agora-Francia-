<?php
session_start();
include 'config.php'; // Fichier contenant les informations de connexion à la base de données

// Récupérer les articles de la base de données
$query = "SELECT Articles.*, Users.UserName FROM Articles JOIN Users ON Articles.UserID = Users.UserID";
$result = $conn->query($query);
$articles = [];
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $articles[] = $row;
    }
}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Accueil - Agora Francia</title>
    <link rel="stylesheet" href="style1.css">
    <style>
        img {
            max-width: 150px;
            max-height: 150px;
        }
    </style>
</head>
<body>
<header>
    <h1>Bienvenue sur Agora Francia</h1>
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
            <img src="<?php echo htmlspecialchars($_SESSION['UserImageURL']); ?>" alt="Mon compte" style="max-width: 120px; max-height: 60px; margin: 0; padding: 0; border: none;">
        </a>
        <a href="logout.php">Déconnexion</a>
    <?php else: ?>
        <a href="login.html">Se connecter</a>
    <?php endif; ?>
</nav>

<div class="content">
    <h2>Introduction</h2>
    <p>Bienvenue sur Agora Francia, votre nouvelle plateforme de choix pour explorer, acheter et vendre des produits variés. Que vous soyez à la recherche de produits rares, de bonnes affaires, ou que vous souhaitiez simplement parcourir notre vaste catalogue, Agora Francia est l'endroit idéal pour vous. Profitez de notre interface intuitive et de notre communauté engagée pour une expérience de shopping en ligne incomparable.</p>
    
    <?php if (isset($_SESSION['user_id'])): ?>
        <p>Bienvenue, <strong><?php echo htmlspecialchars($_SESSION['user_name']); ?></strong> !</p>
        <p>Email : <?php echo htmlspecialchars($_SESSION['user_email']); ?></p>
        <p>Type de compte : <?php echo htmlspecialchars($_SESSION['usertype']); ?></p>
    <?php else: ?>
        <p>Pour commencer, connectez-vous ou créez un compte afin de bénéficier de toutes les fonctionnalités offertes par Agora Francia. Utilisez la navigation ci-dessus pour accéder aux différentes sections de notre site.</p>
    <?php endif; ?>

    <h2>Articles en vente</h2>
    <div class="carousel" id="carousel">
    <?php foreach ($articles as $article): ?>
        <div class="carousel-item">
            <a href="article_details.php?article_id=<?php echo htmlspecialchars($article['ArticleID']); ?>">
                <h3><?php echo htmlspecialchars($article['ArticleName']); ?></h3>
                <img src="<?php echo htmlspecialchars($article['ImageURL']); ?>" alt="<?php echo htmlspecialchars($article['ArticleName']); ?>">
            </a>
            <p>Prix : <?php echo htmlspecialchars($article['Price']); ?> €</p>
            <p>Vendu par : <?php echo htmlspecialchars($article['UserName']); ?></p>
            <p>Qualité : <?php echo htmlspecialchars($article['Quality']); ?></p>
        </div>
    <?php endforeach; ?>
    </div>
</div>
<div id="footer">
    <p>&copy; 2024 Agora Francia. Tous droits réservés.</p>
    <p>
        <a href="mentions-legales.html">Mentions légales</a> |
        <a href="confidentialite.html">Politique de confidentialité</a> |
        <a href="contact.php">Contact</a>
    </p>
</div>
<script src="carousel.js"></script>
</body>
</html>