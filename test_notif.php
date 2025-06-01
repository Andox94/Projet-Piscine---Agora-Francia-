<?php
include 'config.php';
include 'create_notification.php';

// ID de l'utilisateur à qui envoyer la notification
$testUserID = 1; // ⚠️ Mets ici ton ID utilisateur (ex. 3 ou autre)
$message = "✅ Ceci est une notification de test fonctionnelle.";
$articleID = null; // ou un ID d’article si tu veux tester le lien

create_notification($testUserID, $message, $articleID);

echo "Notification test envoyée à l'utilisateur ID $testUserID.";
?>
