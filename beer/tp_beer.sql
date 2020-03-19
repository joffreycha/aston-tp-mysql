-- 1. Quels sont les tickets qui comportent l’article d’ID 500, afficher le numéro de ticket uniquement ?
SELECT NUMERO_TICKET FROM ventes
WHERE ID_ARTICLE = 500;

-- 2. Afficher les tickets du 15/01/2014.
SELECT NUMERO_TICKET FROM ticket
WHERE DATE_VENTE = "2014-01-15";

-- 3. Afficher les tickets émis du 15/01/2014 et le 17/01/2014.
SELECT NUMERO_TICKET, DATE_VENTE FROM ticket
WHERE DATE_VENTE = "2014-01-15" OR DATE_VENTE = "2014-01-17";

-- 4. Editer la liste des articles apparaissant à 50 et plus exemplaires sur un ticket.
SELECT ventes.NUMERO_TICKET, NOM_ARTICLE, COUNT(ventes.ID_ARTICLE) AS exemplaires_article FROM article
INNER JOIN ventes ON article.ID_ARTICLE = ventes.ID_ARTICLE
INNER JOIN ticket ON ticket.NUMERO_TICKET = ventes.NUMERO_TICKET
GROUP BY ticket.NUMERO_TICKET
HAVING exemplaires_article >= 50
ORDER BY NOM_ARTICLE;

-- 5. Quelles sont les tickets émis au mois de mars 2014.
SELECT NUMERO_TICKET
FROM ticket
WHERE ANNEE = 2014
AND EXTRACT(MONTH FROM DATE_VENTE) = 03;

-- 6. Quelles sont les tickets émis entre les mois de mars et avril 2014 ?
SELECT NUMERO_TICKET, DATE_VENTE
FROM ticket
WHERE ANNEE = 2014
AND EXTRACT(MONTH FROM DATE_VENTE) BETWEEN 03 AND 04;

-- 7. Quelles sont les tickets émis au mois de mars et juin 2014 ?
SELECT NUMERO_TICKET, DATE_VENTE
FROM ticket
WHERE ANNEE = 2014
AND EXTRACT(MONTH FROM DATE_VENTE) = 03 
OR EXTRACT(MONTH FROM DATE_VENTE) = 06; 

-- 8. Afficher la liste des bières classée par couleur. (Afficher l’id et le nom)
SELECT ID_ARTICLE, NOM_ARTICLE, NOM_COULEUR
FROM article
INNER JOIN couleur ON article.ID_Couleur = couleur.ID_Couleur
ORDER BY NOM_ARTICLE;

-- 9. Afficher la liste des bières n’ayant pas de couleur. (Afficher l’id et le nom)
SELECT ID_ARTICLE, NOM_ARTICLE
FROM article
WHERE ID_Couleur IS NULL;

-- 10. Lister pour chaque ticket la quantité totale d’articles vendus. (Classer par quantité décroissante)
SELECT NUMERO_TICKET, SUM(QUANTITE) AS quantite_articles_vendus
FROM ventes
GROUP BY NUMERO_TICKET
ORDER BY quantite_articles_vendus DESC;

-- 11. Lister chaque ticket pour lequel la quantité totale d’articles vendus est supérieure à 500. (Classer par quantité décroissante)
SELECT NUMERO_TICKET, SUM(QUANTITE) AS quantite_articles_vendus
FROM ventes
GROUP BY NUMERO_TICKET
HAVING quantite_articles_vendus > 500
ORDER BY quantite_articles_vendus DESC;

-- 12. Lister chaque ticket pour lequel la quantité totale d’articles vendus est supérieure à 500. On exclura du total, les ventes ayant une quantité supérieure à 50 
-- (classer par quantité décroissante)
SELECT NUMERO_TICKET, SUM(QUANTITE) AS quantite_articles_vendus
FROM ventes
WHERE QUANTITE < 50
GROUP BY NUMERO_TICKET
HAVING quantite_articles_vendus > 500
ORDER BY quantite_articles_vendus DESC;

-- 13. Lister les bières de type ‘Trappiste’. (id, nom de la bière, volume et titrage)
SELECT ID_ARTICLE, NOM_ARTICLE, VOLUME, TITRAGE
FROM article
INNER JOIN type ON article.ID_TYPE = type.ID_TYPE
WHERE NOM_TYPE = 'Trappiste';

-- 14. Lister les marques de bières du continent ‘Afrique’
-- 15. Lister les bières du continent ‘Afrique’
-- 16. Lister les tickets (année, numéro de ticket, montant total payé). En sachant que le prix
-- de vente est égal au prix d’achat augmenté de 15% et que l’on n’est pas assujetti à la TVA.
-- 17. Donner le C.A. par année.
-- 18. Lister les quantités vendues de chaque article pour l’année 2016.
-- 19. Lister les quantités vendues de chaque article pour les années 2014,2015 ,2016.
-- 20. Lister les articles qui n’ont fait l’objet d’aucune vente en 2014.
-- 21. Coder de 3 manières différentes la requête suivante : 
-- Lister les pays qui fabriquent des bières de type ‘Trappiste’.