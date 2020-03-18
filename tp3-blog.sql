CREATE DATABASE IF NOT EXISTS `blog` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `blog`;

CREATE TABLE IF NOT EXISTS `UTILISATEUR` (
  `id_utilisateur` int NOT NULL UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `nom_utilisateur` varchar(45),
  `prenom_utilisateur` varchar(45),
  `pseudo_utilisateur` varchar(45) NOT NULL,
  `date_naissance_utilisateur` date NOT NULL,
  `email_utilisateur` varchar(45) NOT NULL,
  `mdp_utilisateur` varchar(500) NOT NULL
);

CREATE TABLE IF NOT EXISTS `ARTICLE` (
  `id_article` int NOT NULL UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `id_utilisateur` int NOT NULL,
  `titre_article` varchar(45) NOT NULL,
  `contenu_article` varchar(45) NOT NULL,
  `date_article` date NOT NULL,
  FOREIGN KEY (`id_utilisateur`) REFERENCES `UTILISATEUR` (`id_utilisateur`)
);

CREATE TABLE IF NOT EXISTS `COMMENTAIRE` (
  `id_commentaire` int NOT NULL UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `id_utilisateur` int NOT NULL,
  `id_article` int NOT NULL,
  `titre_commentaire` varchar(45) NOT NULL,
  `contenu_commentaire` varchar(45) NOT NULL,
  `date_commentaire` date NOT NULL,
  FOREIGN KEY (`id_utilisateur`) REFERENCES `UTILISATEUR` (`id_utilisateur`),
  FOREIGN KEY (`id_article`) REFERENCES `ARTICLE` (`id_article`)
);

CREATE TABLE IF NOT EXISTS `CATEGORIE` (
  `id_categorie` int NOT NULL UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `nom_categorie` varchar(45) NOT NULL
);

CREATE TABLE IF NOT EXISTS `TAG` (
  `id_tag` int NOT NULL UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `nom_tag` varchar(45) NOT NULL
);

CREATE TABLE IF NOT EXISTS `CONTENIR` (
  `id_article` int NOT NULL,
  `id_tag` int NOT NULL,
  FOREIGN KEY (`id_article`) REFERENCES `ARTICLE` (`id_article`),
  FOREIGN KEY (`id_tag`) REFERENCES `TAG` (`id_tag`)
);

CREATE TABLE IF NOT EXISTS `APPARTENIR` (
  `id_article` int NOT NULL,
  `id_categorie` int NOT NULL,
  FOREIGN KEY (`id_article`) REFERENCES `ARTICLE` (`id_article`),
  FOREIGN KEY (`id_categorie`) REFERENCES `CATEGORIE` (`id_categorie`)
);
