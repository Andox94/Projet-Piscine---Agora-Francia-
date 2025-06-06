<?php
session_start();

// Vérifier si l'utilisateur est connecté
if (!isset($_SESSION['user_id'])) {
    header("Location: login.html");
    exit();
}

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "agora";

// Connexion à la base de données
$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$user_id = $_SESSION['user_id'];

// Si le formulaire est soumis pour vérifier le mot de passe
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['verify_password'])) {
    $entered_password = $_POST['password'];

    // Récupérer le mot de passe de l'utilisateur depuis la base de données
    $sql = "SELECT UserPassword, UserName, Email, UserImageURL, Adresse, CarteCredit, DateExpiration, CodeSecurite FROM Users WHERE UserID='$user_id'";
    $result = $conn->query($sql);

    if ($result->num_rows == 1) {
        $user = $result->fetch_assoc();
        $stored_password = $user['UserPassword'];

        // Vérifier si le mot de passe saisi correspond au mot de passe dans la base de données
        if ($entered_password === $stored_password) {
            // Afficher le formulaire pour modifier les informations du compte
            $show_update_form = true;
        } else {
            // Mot de passe incorrect
            $password_error = "Mot de passe incorrect.";
        }
    } else {
        echo "Utilisateur non trouvé.";
        exit();
    }
}

// Si le formulaire de mise à jour est soumis
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['update_info'])) {
    // Récupérer les informations du formulaire
    $new_username = $_POST['username'];
    $new_email = $_POST['email'];
    $new_credit_card = $_POST['credit_card'];
    $new_expiry_date = $_POST['expiry_date'];
    $new_security_code = $_POST['security_code'];
    $new_address = $_POST['address'];
    
    // Gérer le téléchargement de la nouvelle image de profil
    if (isset($_FILES['profile_image']) && $_FILES['profile_image']['error'] == UPLOAD_ERR_OK) {
        $target_dir = "images/";
        $target_file = $target_dir . basename($_FILES["profile_image"]["name"]);
        if (move_uploaded_file($_FILES["profile_image"]["tmp_name"], $target_file)) {
            $new_photo = $target_file;
        } else {
            echo "Erreur lors du téléchargement de l'image.";
            exit();
        }
    } else {
        $new_photo = $user['UserImageURL']; // Conserver l'ancienne image si aucune nouvelle image n'est téléchargée
    }

    // Mettre à jour les informations dans la base de données
    $stmt = $conn->prepare("UPDATE Users SET UserName=?, Email=?, UserImageURL=?, CarteCredit=?, DateExpiration=?, CodeSecurite=?, Adresse=? WHERE UserID=?");
$stmt->bind_param("sssssssi", $new_username, $new_email, $new_photo, $new_credit_card, $new_expiry_date, $new_security_code, $new_address, $user_id);

if ($stmt->execute()) {
    // Mettre à jour la session avec la nouvelle image si elle a changé
    $_SESSION['UserImageURL'] = $new_photo;

    header("Location: moncompte.php?success=1");
    exit();
} else {
    echo "Erreur lors de la mise à jour des informations du compte : " . $stmt->error;
    exit();
}

}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mon Compte - Agora Francia</title>
    <link rel="stylesheet" href="style5.css">
    <link rel="stylesheet" href="style1.css">
</head>
<body>
<header>
    <h1>Mon Compte</h1>
</header>
<nav>
    <a href="accueil.php">Accueil</a>
    <a href="toutAfficher.php">Tout Parcourir</a>
    <a href="notifications.php">Notifications</a>
    <a href="panier.php">Panier</a>

    <?php if (isset($_SESSION['usertype']) && $_SESSION['usertype'] === 'buyer'): ?>
        <a href="panier.php">Panier</a>
    <?php elseif (isset($_SESSION['usertype']) && $_SESSION['usertype'] === 'seller'): ?>
        <a href="offres.php">Mes Offres</a>
    <?php elseif (isset($_SESSION['usertype']) && $_SESSION['usertype'] === 'admin'): ?>
        <a href="gestion.php">Gestion</a>
    <?php endif; ?>

    <?php if (isset($_SESSION['user_id'])): ?>
        <a href="moncompte.php" style="display: inline-block; margin: 0; padding: 0;">
            <img src="<?php echo htmlspecialchars($_SESSION['UserImageURL']); ?>" alt="Image de profil" style="max-width: 120px; max-height: 60px; margin: 0; padding: 0; border: none;">
        </a>
        <a href="logout.php">Déconnexion</a>
    <?php else: ?>
        <a href="login.html">Se connecter</a>
    <?php endif; ?>
</nav>
<div class="content">
    <?php if (isset($show_update_form) && $show_update_form) : ?>
        <!-- Formulaire pour modifier les informations du compte -->
        <form action="moncompte.php" method="post" enctype="multipart/form-data">
            <label for="username">Nom d'utilisateur:</label><br>
            <input type="text" id="username" name="username" value="<?php echo htmlspecialchars($user['UserName']); ?>" required><br><br>
            
            <label for="email">Email:</label><br>
            <input type="email" id="email" name="email" value="<?php echo htmlspecialchars($user['Email']); ?>" required><br><br>
            
            <label for="profile_image">Photo de profil:</label><br>
            <input type="file" id="profile_image" name="profile_image" accept="image/*"><br><br>
            
            <label for="credit_card">Carte de crédit:</label><br>
            <input type="text" id="credit_card" name="credit_card" value="<?php echo htmlspecialchars($user['CarteCredit']); ?>" placeholder="Numéro de carte"><br><br>
            
            <label for="expiry_date">Date d'expiration:</label><br>
            <input type="date" id="expiry_date" name="expiry_date" value="<?php echo htmlspecialchars($user['DateExpiration']); ?>"><br><br>
            
            <label for="security_code">Code de sécurité:</label><br>
            <input type="text" id="security_code" name="security_code" value="<?php echo htmlspecialchars($user['CodeSecurite']); ?>" placeholder="Code de sécurité"><br><br>
            
            <label for="address">Adresse:</label><br>
            <textarea id="address" name="address" rows="4" cols="50" placeholder="Votre adresse"><?php echo htmlspecialchars($user['Adresse']); ?></textarea><br><br>
            
            <input type="submit" name="update_info" value="Enregistrer les modifications">
        </form>
    <?php else : ?>
        <!-- Formulaire pour vérifier le mot de passe -->
        <form action="moncompte.php" method="post">
            <label for="password">Mot de passe:</label><br>
            <input type="password" id="password" name="password" required><br>
            <span><?php echo isset($password_error) ? $password_error : ''; ?></span><br>
            <input type="submit" name="verify_password" value="Vérifier le mot de passe">
        </form>
    <?php endif; ?>
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