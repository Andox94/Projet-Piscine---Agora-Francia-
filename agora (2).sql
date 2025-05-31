-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 28 mai 2025 à 18:57
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `agora`
--

-- --------------------------------------------------------

--
-- Structure de la table `articles`
--

CREATE TABLE `articles` (
  `ArticleID` int(11) NOT NULL,
  `ArticleName` varchar(255) NOT NULL,
  `Description` text DEFAULT NULL,
  `TypeVente` varchar(255) NOT NULL,
  `Price` decimal(10,2) NOT NULL,
  `ImageURL` varchar(255) DEFAULT NULL,
  `VideoURL` varchar(255) DEFAULT NULL,
  `Quality` enum('Neuf','Occasion','Défaut mineur') DEFAULT 'Neuf',
  `Stock` int(11) DEFAULT 1,
  `UserID` int(11) DEFAULT NULL,
  `ItemType` enum('Articles rares','Articles hautes de gamme','Articles réguliers') NOT NULL,
  `CreatedAt` timestamp NULL DEFAULT current_timestamp(),
  `UpdatedAt` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `articles`
--

INSERT INTO `articles` (`ArticleID`, `ArticleName`, `Description`, `TypeVente`, `Price`, `ImageURL`, `VideoURL`, `Quality`, `Stock`, `UserID`, `ItemType`, `CreatedAt`, `UpdatedAt`) VALUES
(1, 'Chaise Bois', 'Chaise en bois en jaune, artistique et ergonomique elle conviendra a des cuisines atypiques mais pas aux incomprehensifs face a l art.', 'Immediat', 1599.99, 'images/chaiseboisjaune.png', NULL, 'Neuf', 2, 2, 'Articles rares', '2024-05-20 04:19:21', '2025-05-26 20:48:45'),
(2, 'Table', 'Table en bois massif, avec pied central, ideal pour vos repas en famille.', 'Immediat', 799.90, 'images/tableboismassif.png', NULL, 'Neuf', 2, 2, 'Articles rares', '2024-05-20 04:19:21', '2025-05-28 09:04:26'),
(3, 'Lampe Vintage', 'Lampe de chevet vintage avec abat-jour en tissu, parfait pour creer une ambiance retro.', 'Immediat', 120.50, 'images/lampevintage.png', NULL, 'Neuf', 9, 2, 'Articles réguliers', '2024-05-20 04:19:21', '2024-06-03 10:57:02'),
(4, 'Canape Cuir', 'Canape en cuir noir, 3 places, design moderne et confortable.', 'Immediat', 2999.99, 'images/canapecuir.png', NULL, 'Neuf', 2, 4, '', '2024-05-20 04:19:21', '2024-06-03 11:06:42'),
(5, 'Bibliotheque', 'Grande bibliotheque en chene, 5 etageres, ideale pour ranger vos livres et objets de decoration.', 'Immediat', 450.75, 'images/bibliotheque.png', NULL, 'Neuf', 4, 2, 'Articles réguliers', '2024-05-20 04:19:21', '2025-05-27 09:03:09'),
(6, 'Tapis Persan', 'Tapis persan authentique, fait main, motifs traditionnels, ideal pour un salon elegant.', 'Immediat', 1200.00, 'images/tapispersan.png', NULL, 'Neuf', 1, 2, 'Articles rares', '2024-05-20 04:19:21', '2024-06-03 11:24:42'),
(7, 'Lustre Cristal', 'Lustre en cristal, 8 branches, parfait pour une salle a manger luxueuse.', 'Immediat', 850.00, 'images/lustrecristal.png', NULL, 'Neuf', 4, 2, 'Articles réguliers', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(8, 'Chaise de Bureau', 'Chaise de bureau ergonomique, avec support lombaire et accoudoirs ajustables.', 'Immediat', 250.00, 'images/chaisebureau.png', NULL, 'Neuf', 15, 2, 'Articles réguliers', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(9, 'Table Basse', 'Table basse en verre trempe avec pieds en metal, design moderne.', 'Immediat', 299.99, 'images/tablebasse.png', NULL, 'Neuf', 8, 2, 'Articles rares', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(10, 'Lit Double', 'Lit double en bois massif avec tete de lit capitonnee.', 'Immediat', 1899.99, 'images/litdouble.png', NULL, 'Neuf', 3, 2, 'Articles réguliers', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(11, 'Montre Rolex', 'Montre Rolex Submariner en acier inoxydable, etanche et elegante.', 'Immediat', 7500.00, 'images/montre_rolex.png', NULL, 'Neuf', 1, 6, 'Articles rares', '2024-05-20 04:19:21', '2024-06-03 08:24:52'),
(12, 'Console de Jeux', 'Console de jeux video derniere generation avec 2 manettes incluses.', 'Immediat', 499.99, 'images/console_jeux.png', NULL, 'Neuf', 19, 8, 'Articles réguliers', '2024-05-20 04:19:21', '2024-06-03 08:49:03'),
(13, 'Camera Reflex', 'Camera Reflex numerique avec objectif 24-70mm, parfait pour les photographes professionnels.', 'Immediat', 2500.00, 'images/camera_reflex.png', NULL, 'Neuf', 0, 2, 'Articles rares', '2024-05-20 04:19:21', '2024-06-03 09:40:44'),
(14, 'Smartphone', 'Smartphone dernier modele avec 128GB de memoire interne.', 'Immediat', 999.99, 'images/smartphone.png', NULL, 'Neuf', 50, 4, 'Articles réguliers', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(15, 'Bicyclette de Course', 'Bicyclette de course legere avec cadre en carbone, ideale pour les competitions.', 'Immediat', 1200.00, 'images/bicyclette_course.png', NULL, 'Neuf', 10, 2, 'Articles rares', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(16, 'Ecouteurs Sans Fil', 'Ecouteurs sans fil avec reduction de bruit active, autonomie de 20 heures.', 'Immediat', 199.99, 'images/ecouteurs_sansfil.png', NULL, 'Neuf', 30, 8, 'Articles réguliers', '2024-05-20 04:19:21', '2024-06-03 08:25:11'),
(17, 'Drone', 'Drone avec camera 4K et stabilisation d image, parfait pour les prises de vue aeriennes.', 'Immediat', 899.99, 'images/drone.png', NULL, 'Neuf', 5, 2, 'Articles rares', '2024-05-20 04:19:21', '2025-05-27 13:52:11'),
(18, 'Ordinateur Portable', 'Ordinateur portable ultra-fin avec ecran Retina et 512GB de SSD.', 'Immediat', 1500.00, 'images/ordinateur_portable.png', NULL, 'Neuf', 25, 8, 'Articles réguliers', '2024-05-20 04:19:21', '2024-06-03 08:25:19'),
(19, 'Appareil Photo Instantane', 'Appareil photo instantane avec pellicule couleur, parfait pour les souvenirs instantanes.', 'Immediat', 120.00, 'images/appareil_photo_instantane.png', NULL, 'Neuf', 39, 2, 'Articles réguliers', '2024-05-20 04:19:21', '2024-06-03 08:47:56'),
(20, 'Casque de Realite Virtuelle', 'Casque de realite virtuelle avec controleurs, immersion totale garantie.', 'Immediat', 399.99, 'images/casque_vr.png', NULL, 'Neuf', 10, 4, 'Articles réguliers', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(21, 'Enceinte Bluetooth', 'Enceinte Bluetooth portable avec son stereo et autonomie de 12 heures.', 'Immediat', 150.00, 'images/enceinte_bluetooth.png', NULL, 'Neuf', 50, 8, 'Articles réguliers', '2024-05-20 04:19:21', '2024-06-03 08:25:27'),
(22, 'Guitare Electrique', 'Guitare electrique avec ampli inclus, ideale pour les musiciens.', 'Immediat', 800.00, 'images/guitare_electrique.png', NULL, 'Neuf', 8, 2, 'Articles rares', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(23, 'Lunettes de Soleil', 'Lunettes de soleil de marque avec protection UV 400.', 'Immediat', 120.00, 'images/lunettes_soleil.png', NULL, 'Neuf', 100, 4, 'Articles réguliers', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(24, 'Cafetiere Expresso', 'Cafetiere expresso automatique avec mousseur a lait integre.', 'Immediat', 299.99, 'images/cafetiere_expresso.png', NULL, 'Neuf', 25, 8, 'Articles réguliers', '2024-05-20 04:19:21', '2024-06-03 08:25:34'),
(25, 'Voiture Electrique', 'Voiture electrique compacte avec une autonomie de 300 km.', 'Negociation', 19999.99, 'images/voiture_electrique.png', NULL, 'Neuf', 0, 2, 'Articles réguliers', '2024-05-20 04:19:21', '2025-05-28 14:15:16'),
(26, 'Velo de Montagne', 'Velo de montagne tout-terrain avec suspension complete.', 'Negociation', 799.99, 'images/velo_montagne.png', NULL, 'Neuf', 7, 2, 'Articles réguliers', '2024-05-20 04:19:21', '2025-05-28 14:30:02'),
(27, 'Ordinateur Gaming', 'Ordinateur gaming avec processeur Intel i9 et carte graphique RTX 3080.', 'Enchere', 2499.99, 'images/ordinateur_gaming.png', NULL, 'Occasion', 8, 2, 'Articles réguliers', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(28, 'Piano a Queue', 'Piano a queue Yamaha, ideal pour les musiciens professionnels.', 'Negociation', 8999.99, 'images/piano_queue.png', NULL, 'Occasion', 2, 2, 'Articles réguliers', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(29, 'Collection de Timbres', 'Collection de timbres rares du 19eme siecle.', 'Enchere', 1499.99, 'images/collection_timbres.png', NULL, 'Occasion', 1, 2, 'Articles rares', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(30, 'Montre de Luxe', 'Montre de luxe Patek Philippe, en or rose.', 'Negociation', 25000.00, 'images/montre_luxe.png', NULL, 'Neuf', 2, 2, 'Articles rares', '2024-05-20 04:19:21', '2024-06-03 09:20:10'),
(31, 'Yacht de Luxe', 'Yacht de luxe avec 5 cabines et une piscine.', 'Negociation', 1500000.00, 'images/yacht_luxe.png', NULL, 'Neuf', 2, 2, '', '2024-05-20 04:19:21', '2025-05-27 13:52:37'),
(32, 'Bague en Diamant', 'Bague en diamant taille princesse de 2 carats.', 'Negociation', 7500.00, 'images/bague_diamant.png', NULL, 'Neuf', 5, 2, 'Articles réguliers', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(33, 'Sculpture en Bronze', 'Sculpture en bronze representant une scene mythologique.', 'Enchere', 4500.00, 'images/sculpture_bronze.png', NULL, 'Occasion', 1, 2, 'Articles rares', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(34, 'Chaise Bois', 'Chaise en bois en jaune, artistique et ergonomique elle conviendra a des cuisines atypiques mais pas aux incomprehensifs face a l art.', 'Immediat', 1599.99, 'images/chaiseboisjaune.png', NULL, 'Neuf', 1, 2, 'Articles rares', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(35, 'Table', 'Table en bois massif, avec pied central, ideal pour vos repas en famille.', 'Immediat', 799.90, 'images/tableboismassif.png', NULL, 'Neuf', 1, 2, 'Articles rares', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(36, 'Lampe Vintage', 'Lampe de chevet vintage avec abat-jour en tissu, parfait pour creer une ambiance retro.', 'Immediat', 120.50, 'images/lampevintage.png', NULL, 'Neuf', 10, 2, 'Articles réguliers', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(37, 'Canape Cuir', 'Canape en cuir noir, 3 places, design moderne et confortable.', 'Immediat', 2999.99, 'images/canapecuir.png', NULL, 'Neuf', 3, 4, '', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(38, 'Bibliotheque', 'Grande bibliotheque en chene, 5 etageres, ideale pour ranger vos livres et objets de decoration.', 'Immediat', 450.75, 'images/bibliotheque.png', NULL, 'Neuf', 5, 2, 'Articles réguliers', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(39, 'Tapis Persan', 'Tapis persan authentique, fait main, motifs traditionnels, ideal pour un salon elegant.', 'Immediat', 1200.00, 'images/tapispersan.png', NULL, 'Neuf', 2, 2, 'Articles rares', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(40, 'Lustre Cristal', 'Lustre en cristal, 8 branches, parfait pour une salle a manger luxueuse.', 'Immediat', 850.00, 'images/lustrecristal.png', NULL, 'Neuf', 4, 2, 'Articles réguliers', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(41, 'Chaise de Bureau', 'Chaise de bureau ergonomique, avec support lombaire et accoudoirs ajustables.', 'Immediat', 250.00, 'images/chaisebureau.png', NULL, 'Neuf', 15, 2, 'Articles réguliers', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(42, 'Table Basse', 'Table basse en verre trempe avec pieds en metal, design moderne.', 'Immediat', 299.99, 'images/tablebasse.png', NULL, 'Neuf', 8, 2, 'Articles rares', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(43, 'Lit Double', 'Lit double en bois massif avec tete de lit capitonnee.', 'Immediat', 1899.99, 'images/litdouble.png', NULL, 'Neuf', 3, 2, 'Articles réguliers', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(44, 'Montre Rolex', 'Montre Rolex Submariner en acier inoxydable, etanche et elegante.', 'Immediat', 7500.00, 'images/montre_rolex.png', NULL, 'Neuf', 1, 5, 'Articles rares', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(45, 'Console de Jeux', 'Console de jeux video derniere generation avec 2 manettes incluses.', 'Immediat', 499.99, 'images/console_jeux.png', NULL, 'Neuf', 20, 3, 'Articles réguliers', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(46, 'Camera Reflex', 'Camera Reflex numerique avec objectif 24-70mm, parfait pour les photographes professionnels.', 'Immediat', 2500.00, 'images/camera_reflex.png', NULL, 'Neuf', 5, 2, 'Articles rares', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(47, 'Smartphone', 'Smartphone dernier modele avec 128GB de memoire interne.', 'Immediat', 999.99, 'images/smartphone.png', NULL, 'Neuf', 50, 4, 'Articles réguliers', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(48, 'Bicyclette de Course', 'Bicyclette de course legere avec cadre en carbone, ideale pour les competitions.', 'Immediat', 1200.00, 'images/bicyclette_course.png', NULL, 'Neuf', 9, 2, 'Articles rares', '2024-05-20 04:19:21', '2025-05-27 12:13:55'),
(49, 'Ecouteurs Sans Fil', 'Ecouteurs sans fil avec reduction de bruit active, autonomie de 20 heures.', 'Immediat', 199.99, 'images/ecouteurs_sansfil.png', NULL, 'Neuf', 30, 3, 'Articles réguliers', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(50, 'Drone', 'Drone avec camera 4K et stabilisation d image, parfait pour les prises de vue aeriennes.', 'Immediat', 899.99, 'images/drone.png', NULL, 'Neuf', 15, 2, 'Articles rares', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(51, 'Ordinateur Portable', 'Ordinateur portable ultra-fin avec ecran Retina et 512GB de SSD.', 'Immediat', 1500.00, 'images/ordinateur_portable.png', NULL, 'Neuf', 25, 3, 'Articles réguliers', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(52, 'Appareil Photo Instantane', 'Appareil photo instantane avec pellicule couleur, parfait pour les souvenirs instantanes.', 'Immediat', 120.00, 'images/appareil_photo_instantane.png', NULL, 'Neuf', 40, 2, 'Articles réguliers', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(53, 'Casque de Realite Virtuelle', 'Casque de realite virtuelle avec controleurs, immersion totale garantie.', 'Immediat', 399.99, 'images/casque_vr.png', NULL, 'Neuf', 10, 4, 'Articles réguliers', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(54, 'Enceinte Bluetooth', 'Enceinte Bluetooth portable avec son stereo et autonomie de 12 heures.', 'Immediat', 150.00, 'images/enceinte_bluetooth.png', NULL, 'Neuf', 50, 3, 'Articles réguliers', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(55, 'Guitare Electrique', 'Guitare electrique avec ampli inclus, ideale pour les musiciens.', 'Immediat', 800.00, 'images/guitare_electrique.png', NULL, 'Neuf', 8, 2, 'Articles rares', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(56, 'Lunettes de Soleil', 'Lunettes de soleil de marque avec protection UV 400.', 'Immediat', 120.00, 'images/lunettes_soleil.png', NULL, 'Neuf', 100, 4, 'Articles réguliers', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(57, 'Cafetiere Expresso', 'Cafetiere expresso automatique avec mousseur a lait integre.', 'Immediat', 299.99, 'images/cafetiere_expresso.png', NULL, 'Neuf', 25, 3, 'Articles réguliers', '2024-05-20 04:19:21', '2024-05-21 03:21:29'),
(58, 'Voiture Electrique', 'Voiture electrique compacte avec une autonomie de 300 km.', 'Negociation', 19999.99, 'images/voiture_electrique.png', NULL, 'Neuf', 5, 2, 'Articles réguliers', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(59, 'Velo de Montagne', 'Velo de montagne tout-terrain avec suspension complete.', 'Negociation', 799.99, 'images/velo_montagne.png', NULL, 'Neuf', 10, 2, 'Articles réguliers', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(60, 'Ordinateur Gaming', 'Ordinateur gaming avec processeur Intel i9 et carte graphique RTX 3080.', 'Enchere', 2499.99, 'images/ordinateur_gaming.png', NULL, 'Occasion', 8, 2, 'Articles réguliers', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(61, 'Piano a Queue', 'Piano a queue Yamaha, ideal pour les musiciens professionnels.', 'Negociation', 8999.99, 'images/piano_queue.png', NULL, 'Occasion', 2, 2, 'Articles réguliers', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(62, 'Collection de Timbres', 'Collection de timbres rares du 19eme siecle.', 'Enchere', 1499.99, 'images/collection_timbres.png', NULL, 'Occasion', 1, 2, 'Articles rares', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(63, 'Montre de Luxe', 'Montre de luxe Patek Philippe, en or rose.', 'Negociation', 25000.00, 'images/montre_luxe.png', NULL, 'Neuf', 3, 2, 'Articles rares', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(64, 'Yacht de Luxe', 'Yacht de luxe avec 5 cabines et une piscine.', 'Negociation', 1500000.00, 'images/yacht_luxe.png', NULL, 'Neuf', 1, 2, '', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(65, 'Bague en Diamant', 'Bague en diamant taille princesse de 2 carats.', 'Negociation', 7500.00, 'images/bague_diamant.png', NULL, 'Neuf', 5, 2, 'Articles réguliers', '2024-05-20 04:19:21', '2024-05-21 03:21:27'),
(66, 'Sculpture en Bronze', 'Sculpture en bronze representant une scene mythologique.', 'Enchere', 4500.00, 'images/sculpture_bronze.png', NULL, 'Occasion', 1, 2, 'Articles rares', '2024-05-20 04:19:21', '2024-06-03 11:04:40');

-- --------------------------------------------------------

--
-- Structure de la table `enchere`
--

CREATE TABLE `enchere` (
  `EnchereID` int(11) NOT NULL,
  `ArticleID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `BidAmount` decimal(10,2) NOT NULL,
  `BidTime` timestamp NULL DEFAULT current_timestamp(),
  `StartingPrice` decimal(10,2) NOT NULL,
  `WinningBid` decimal(10,2) DEFAULT NULL,
  `WinnerID` int(11) DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `ImageURL` varchar(255) DEFAULT NULL,
  `VideoURL` varchar(255) DEFAULT NULL,
  `Quality` enum('Neuf','Occasion','Défaut mineur') DEFAULT 'Neuf',
  `ItemType` enum('Articles rares','Articles hautes de gamme','Articles réguliers') NOT NULL,
  `CreatedAt` timestamp NULL DEFAULT current_timestamp(),
  `UpdatedAt` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `EndTime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `negociations`
--

CREATE TABLE `negociations` (
  `NegociationID` int(11) NOT NULL,
  `ArticleID` int(11) DEFAULT NULL,
  `UserID` int(11) DEFAULT NULL,
  `ProposedPrice` decimal(10,2) DEFAULT NULL,
  `Status` enum('PendingSeller','PendingBuyer','Accepted','Rejected') DEFAULT 'PendingSeller',
  `CreatedAt` timestamp NULL DEFAULT current_timestamp(),
  `EtapeNego` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `notifications`
--

CREATE TABLE `notifications` (
  `NotificationID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `TypeVente` varchar(50) DEFAULT 'Tous',
  `TypeAchat` varchar(50) DEFAULT 'Tous',
  `Rarete` varchar(50) DEFAULT 'Tous',
  `Quantity` int(11) NOT NULL,
  `CreatedAt` timestamp NULL DEFAULT current_timestamp(),
  `Message` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `panier`
--

CREATE TABLE `panier` (
  `PanierID` int(11) NOT NULL,
  `UserID` int(11) DEFAULT NULL,
  `DateCreation` timestamp NULL DEFAULT current_timestamp(),
  `Status` enum('En cours','Validé','Annulé') DEFAULT 'En cours'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `panierarticles`
--

CREATE TABLE `panierarticles` (
  `PanierArticleID` int(11) NOT NULL,
  `PanierID` int(11) DEFAULT NULL,
  `ArticleID` int(11) DEFAULT NULL,
  `Quantity` int(11) NOT NULL DEFAULT 1,
  `PrixNegocie` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `remises`
--

CREATE TABLE `remises` (
  `RemiseID` int(11) NOT NULL,
  `PanierID` int(11) DEFAULT NULL,
  `MontantRemise` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `remise_enchere`
--

CREATE TABLE `remise_enchere` (
  `RemiseID` int(11) NOT NULL,
  `PanierID` int(11) DEFAULT NULL,
  `DifferencePrix` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `UserID` int(11) NOT NULL,
  `UserName` varchar(50) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `UserPassword` varchar(255) NOT NULL,
  `UserType` varchar(50) NOT NULL,
  `UserImageURL` varchar(255) DEFAULT NULL,
  `Adresse` varchar(255) DEFAULT NULL,
  `CarteCredit` varchar(20) DEFAULT NULL,
  `DateExpiration` date DEFAULT NULL,
  `CodeSecurite` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`UserID`, `UserName`, `Email`, `UserPassword`, `UserType`, `UserImageURL`, `Adresse`, `CarteCredit`, `DateExpiration`, `CodeSecurite`) VALUES
(1, 'admin', 'admin@example.com', 'password', 'admin', 'images/jean_lasalle.jpg', '123 Rue de l\'Admin', '1234567890123456', '2024-12-31', 123),
(2, 'vendeur1', 'vendeur1@example.com', 'password', 'seller', NULL, '456 Avenue du Vendeur', '9876543210987654', '2025-06-30', 456),
(3, 'acheteur1', 'acheteur1@example.com', 'password', 'buyer', 'images/vendeur.png', '789 Boulevard de l\'Acheteur', '1111222233334444', '2023-09-30', 789),
(4, 'seller2', 'seller2@example.com', 'password', 'seller', NULL, '321 Rue du Vendeur', '2222333344445555', '2024-07-31', 246),
(5, 'buyer2', 'buyer2@example.com', 'password', 'buyer', 'images/vendeur2.png', '654 Avenue de l\'Acheteur', '5555666677778888', '2025-03-31', 135),
(6, 'seller3', 'seller3@example.com', 'password', 'seller', NULL, '987 Boulevard du Vendeur', '6666777788889999', '2023-11-30', 579),
(7, 'buyer3', 'buyer3@example.com', 'password', 'buyer', NULL, '123 Rue de l\'Acheteur', '9999888877776666', '2024-05-31', 246),
(8, 'seller4', 'seller4@example.com', 'password', 'seller', NULL, '456 Avenue du Vendeur', '3333444455556666', '2025-01-31', 891),
(9, 'buyer4', 'buyer4@example.com', 'password', 'buyer', NULL, '789 Boulevard de l\'Acheteur', '7777666655554444', '2023-10-31', 123);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `articles`
--
ALTER TABLE `articles`
  ADD PRIMARY KEY (`ArticleID`),
  ADD KEY `UserID` (`UserID`);

--
-- Index pour la table `enchere`
--
ALTER TABLE `enchere`
  ADD PRIMARY KEY (`EnchereID`),
  ADD KEY `ArticleID` (`ArticleID`),
  ADD KEY `UserID` (`UserID`),
  ADD KEY `WinnerID` (`WinnerID`);

--
-- Index pour la table `negociations`
--
ALTER TABLE `negociations`
  ADD PRIMARY KEY (`NegociationID`),
  ADD KEY `ArticleID` (`ArticleID`),
  ADD KEY `UserID` (`UserID`);

--
-- Index pour la table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`NotificationID`),
  ADD KEY `UserID` (`UserID`);

--
-- Index pour la table `panier`
--
ALTER TABLE `panier`
  ADD PRIMARY KEY (`PanierID`),
  ADD KEY `UserID` (`UserID`);

--
-- Index pour la table `panierarticles`
--
ALTER TABLE `panierarticles`
  ADD PRIMARY KEY (`PanierArticleID`),
  ADD KEY `PanierID` (`PanierID`),
  ADD KEY `ArticleID` (`ArticleID`);

--
-- Index pour la table `remises`
--
ALTER TABLE `remises`
  ADD PRIMARY KEY (`RemiseID`),
  ADD KEY `PanierID` (`PanierID`);

--
-- Index pour la table `remise_enchere`
--
ALTER TABLE `remise_enchere`
  ADD PRIMARY KEY (`RemiseID`),
  ADD KEY `PanierID` (`PanierID`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `articles`
--
ALTER TABLE `articles`
  MODIFY `ArticleID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT pour la table `enchere`
--
ALTER TABLE `enchere`
  MODIFY `EnchereID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT pour la table `negociations`
--
ALTER TABLE `negociations`
  MODIFY `NegociationID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT pour la table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `NotificationID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `panier`
--
ALTER TABLE `panier`
  MODIFY `PanierID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT pour la table `panierarticles`
--
ALTER TABLE `panierarticles`
  MODIFY `PanierArticleID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT pour la table `remises`
--
ALTER TABLE `remises`
  MODIFY `RemiseID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT pour la table `remise_enchere`
--
ALTER TABLE `remise_enchere`
  MODIFY `RemiseID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `articles`
--
ALTER TABLE `articles`
  ADD CONSTRAINT `articles_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`);

--
-- Contraintes pour la table `enchere`
--
ALTER TABLE `enchere`
  ADD CONSTRAINT `enchere_ibfk_1` FOREIGN KEY (`ArticleID`) REFERENCES `articles` (`ArticleID`),
  ADD CONSTRAINT `enchere_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`),
  ADD CONSTRAINT `enchere_ibfk_3` FOREIGN KEY (`WinnerID`) REFERENCES `users` (`UserID`);

--
-- Contraintes pour la table `negociations`
--
ALTER TABLE `negociations`
  ADD CONSTRAINT `negociations_ibfk_1` FOREIGN KEY (`ArticleID`) REFERENCES `articles` (`ArticleID`),
  ADD CONSTRAINT `negociations_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`);

--
-- Contraintes pour la table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`);

--
-- Contraintes pour la table `panier`
--
ALTER TABLE `panier`
  ADD CONSTRAINT `panier_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`);

--
-- Contraintes pour la table `panierarticles`
--
ALTER TABLE `panierarticles`
  ADD CONSTRAINT `panierarticles_ibfk_1` FOREIGN KEY (`PanierID`) REFERENCES `panier` (`PanierID`) ON DELETE CASCADE,
  ADD CONSTRAINT `panierarticles_ibfk_2` FOREIGN KEY (`ArticleID`) REFERENCES `articles` (`ArticleID`) ON DELETE CASCADE;

--
-- Contraintes pour la table `remises`
--
ALTER TABLE `remises`
  ADD CONSTRAINT `remises_ibfk_1` FOREIGN KEY (`PanierID`) REFERENCES `panier` (`PanierID`) ON DELETE CASCADE;

--
-- Contraintes pour la table `remise_enchere`
--
ALTER TABLE `remise_enchere`
  ADD CONSTRAINT `remise_enchere_ibfk_1` FOREIGN KEY (`PanierID`) REFERENCES `panier` (`PanierID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
