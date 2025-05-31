<?php
session_start();
include 'config.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $negociation_id = $_POST['negociation_id'];
    $current_user_id = $_SESSION['user_id'];

    // Récupération des infos de la négociation
    $sql = "SELECT ArticleID, ProposedPrice, UserID FROM Negociations WHERE NegociationID = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $negociation_id);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result && $result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $article_id = $row['ArticleID'];
        $proposed_price = $row['ProposedPrice'];
        $buyer_id = $row['UserID'];  // Dernier acteur de la négo = prochain acheteur

        // ✅ Mise à jour de la négociation
        $update_query = "UPDATE Negociations SET Status = 'Accepted' WHERE NegociationID = ?";
        $stmt = $conn->prepare($update_query);
        $stmt->bind_param("i", $negociation_id);
        $stmt->execute();

        // ✅ Création ou récupération du panier de l’acheteur
        $check_cart = "SELECT PanierID FROM Panier WHERE UserID = ? AND Status = 'En cours'";
        $stmt = $conn->prepare($check_cart);
        $stmt->bind_param("i", $buyer_id);
        $stmt->execute();
        $cart_result = $stmt->get_result();

        if ($cart_result->num_rows > 0) {
            $cart_id = $cart_result->fetch_assoc()['PanierID'];
        } else {
            $insert_cart = "INSERT INTO Panier (UserID, Status) VALUES (?, 'En cours')";
            $stmt = $conn->prepare($insert_cart);
            $stmt->bind_param("i", $buyer_id);
            $stmt->execute();
            $cart_id = $conn->insert_id;
        }

        // ✅ Récupération du prix d’origine
        $price_query = "SELECT Price FROM Articles WHERE ArticleID = ?";
        $stmt = $conn->prepare($price_query);
        $stmt->bind_param("i", $article_id);
        $stmt->execute();
        $price_result = $stmt->get_result();

        if ($price_result->num_rows > 0) {
            $original_price = $price_result->fetch_assoc()['Price'];
            $remise = $original_price - $proposed_price;

            // ✅ Insertion de la remise
            $stmt = $conn->prepare("INSERT INTO Remises (PanierID, MontantRemise) VALUES (?, ?)");
            $stmt->bind_param("id", $cart_id, $remise);
            $stmt->execute();
        }

        // ✅ Ajout de l'article dans le panier
        $stmt = $conn->prepare("INSERT INTO PanierArticles (PanierID, ArticleID, Quantity) VALUES (?, ?, 1)");
        $stmt->bind_param("ii", $cart_id, $article_id);
        $stmt->execute();

        // ✅ Mise à jour du stock
        $stmt = $conn->prepare("UPDATE Articles SET Stock = Stock - 1 WHERE ArticleID = ?");
        $stmt->bind_param("i", $article_id);
        $stmt->execute();

        // 🔁 Redirection
        if ($_SESSION['usertype'] == 'buyer' && $_SESSION['user_id'] == $buyer_id) {
            header("Location: panier.php");
        } else {
            header("Location: notifications.php?message=accepted");
        }

        exit();
    } else {
        echo "Erreur : négociation introuvable.";
        exit();
    }
}
?>
