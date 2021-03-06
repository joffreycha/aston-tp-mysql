CREATE DATABASE `site` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;

CREATE TABLE `visiteur` (
  `id_visiteur` int NOT NULL AUTO_INCREMENT,
  `ip_visiteur` varchar(45) NOT NULL,
  `date_premiere_visite_visiteur` datetime DEFAULT CURRENT_TIMESTAMP,
  `date_derniere_visite_visiteur` datetime DEFAULT NULL,
  `nombre_visites` int DEFAULT NULL,
  PRIMARY KEY (`id_visiteur`),
  UNIQUE KEY `id_visiteur_UNIQUE` (`id_visiteur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `nombre_de_visiteurs` AS select count(`visiteur`.`id_visiteur`) AS `nombre_de_visiteurs` from `visiteur`;
