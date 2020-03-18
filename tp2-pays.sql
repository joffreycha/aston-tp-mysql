CREATE DATABASE IF NOT EXISTS `relations` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `relations`;

CREATE TABLE IF NOT EXISTS `pays` (
  `id_pays` int NOT NULL UNIQUE PRIMARY KEY,
  `nom_pays` varchar(45) NOT NULL
);

CREATE TABLE IF NOT EXISTS `ville` (
  `id_ville` int NOT NULL UNIQUE PRIMARY KEY,
  `id_pays` int NOT NULL,
  `nom_ville` varchar(45) NOT NULL,
  FOREIGN KEY (`id_pays`) REFERENCES `pays` (`id_pays`)
);

CREATE TABLE IF NOT EXISTS `langue` (
  `id_langue` int NOT NULL UNIQUE PRIMARY KEY,
  `nom_langue` varchar(45) NOT NULL
);

CREATE TABLE IF NOT EXISTS `pays_langue` (
  `id_pays` int NOT NULL,
  `id_langue` int NOT NULL,
  FOREIGN KEY (`id_pays`) REFERENCES `pays` (`id_pays`),
  FOREIGN KEY (`id_langue`) REFERENCES `langue` (`id_langue`)
);

CREATE VIEW `pays_qui_parlent_anglais` AS 
SELECT nom_pays FROM pays
INNER JOIN pays_langue ON pays.id_pays = pays_langue.id_pays
INNER JOIN langue ON langue.id_langue = pays_langue.id_langue
WHERE nom_langue = "Anglais";
