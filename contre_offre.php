<?php
session_start();
include 'config.php';

if (!isset($_SESSION['user_id'])) {
    echo "Veuillez vous connecter.";
    exit();
}

if (isset($_POST['negociation_id']) && isset($_POST['proposed_price'])) {
    $negociation_id = $_POST['negociation_id'];
    $nouveau_prix = (float) $_POST['proposed_price'];
    $user_id = $_SESSION['user_id'];

    // Récupérer les infos de la négociation initiale
    $sql = "SELECT N.ArticleID, N.EtapeNego, N.UserID AS AcheteurID, A.UserID AS SellerID
            FROM Negociations N
            JOIN Articles A ON N.ArticleID = A.ArticleID
            WHERE N.NegociationID = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $negociation_id);
    $stmt->execute();
    $result = $stmt->get_result();

   if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $article_id     = $row['ArticleID'];
    $ancien_etape   = $row['EtapeNego'];
    $seller_id      = $row['SellerID'];
    $acheteur_id    = $row['AcheteurID'];

    // Déterminer si l'utilisateur est le vendeur
    $is_seller = ($user_id == $seller_id);

    // Inverser les rôles pour passer la main
    if ($is_seller) {
        $nouveau_user_id = $acheteur_id;
        $nouveau_statut  = 'PendingBuyer';
    } else {
        $nouveau_user_id = $seller_id;
        $nouveau_statut  = 'PendingSeller';
    }

    $nouvelle_etape = $ancien_etape + 1;

    if ($nouvelle_etape > 5) {
        echo "Nombre maximal d'étapes atteint.";
        exit();
    }

    // 🔁 Mise à jour dans la base
    $sql_update = "UPDATE Negociations 
                   SET UserID = ?, ProposedPrice = ?, Status = ?, EtapeNego = ?, CreatedAt = NOW()
                   WHERE NegociationID = ?";
    
    $stmt_update = $conn->prepare($sql_update);
    $stmt_update->bind_param("dssii", $nouveau_user_id, $nouveau_prix, $nouveau_statut, $nouvelle_etape, $negociation_id);

    if ($stmt_update->execute()) {
        header("Location: notifications.php?message=countered");
        exit();
    } else {
        echo "Erreur lors de la mise à jour de la contre-offre : " . $stmt_update->error;
        exit();
    }

} else {
    echo "Erreur : négociation introuvable.";
    exit();
}


} else {
    echo "Données manquantes.";
    exit();
}
?>