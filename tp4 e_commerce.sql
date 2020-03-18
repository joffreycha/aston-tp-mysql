CREATE DATABASE IF NOT EXISTS `e_commerce` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `e_commerce`;

CREATE TABLE IF NOT EXISTS `UTILISATEUR` (
  `id_utilisateur` int NOT NULL UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `nom_utilisateur` varchar(45) NOT NULL,
  `prenom_utilisateur` varchar(45) NOT NULL,
  `pseudo_utilisateur` varchar(45),
  `date_naissance_utilisateur` date,
  `email_utilisateur` varchar(45) NOT NULL,
  `telephone1_utilisateur` varchar(20),
  `telephone2_utilisateur` varchar(20),
  `mdp_utilisateur` varchar(500) NOT NULL
);

CREATE TABLE IF NOT EXISTS `PRODUIT` (
  `id_produit` int NOT NULL UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `designation_produit` varchar(45) NOT NULL,
  `description_produit` date NOT NULL,
  `date_fabricarion_produit` date,
  `date_peremption_produit` date,
  `id_utilisateur` int
);
