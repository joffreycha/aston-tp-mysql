-- 1. Quels sont les tickets qui comportent l’article d’ID 500, afficher le numéro de ticket uniquement ?
SELECT CONCAT(ANNEE, " ", NUMERO_TICKET) AS ID_TICKET FROM ventes
WHERE ID_ARTICLE = 500;

-- 2. Afficher les tickets du 15/01/2014.
SELECT NUMERO_TICKET FROM ticket
WHERE DATE_VENTE = "2014-01-15";

-- 3. Afficher les tickets émis le 15/01/2014 et le 17/01/2014.
SELECT NUMERO_TICKET, DATE_VENTE FROM ticket
WHERE DATE_VENTE = "2014-01-15" OR DATE_VENTE = "2014-01-17";

-- 4. Editer la liste des articles apparaissant à 50 et plus exemplaires sur un ticket.
SELECT CONCAT(ventes.ANNEE, " ", ventes.NUMERO_TICKET) AS ID_TICKET, ID_ARTICLE, NOM_ARTICLE, QUANTITE
FROM ventes
INNER JOIN article using(ID_ARTICLE)
WHERE QUANTITE >= 50
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
AND (EXTRACT(MONTH FROM DATE_VENTE) = 03 
OR EXTRACT(MONTH FROM DATE_VENTE) = 06); 

-- 8. Afficher la liste des bières classée par couleur. (Afficher l’id et le nom)
SELECT DISTINCT ID_ARTICLE, NOM_ARTICLE, VOLUME, NOM_COULEUR
FROM article
INNER JOIN couleur ON article.ID_Couleur = couleur.ID_Couleur
ORDER BY NOM_ARTICLE;

-- 9. Afficher la liste des bières n’ayant pas de couleur. (Afficher l’id et le nom)
SELECT ID_ARTICLE, NOM_ARTICLE
FROM article
WHERE ID_Couleur IS NULL;

-- 10. Lister pour chaque ticket la quantité totale d’articles vendus. (Classer par quantité décroissante)
SELECT CONCAT(ANNEE, " ", NUMERO_TICKET) AS ID_TICKET, SUM(QUANTITE) AS QUANTITE_ARTICLES_VENDUS
FROM ventes
GROUP BY ID_TICKET
ORDER BY QUANTITE_ARTICLES_VENDUS DESC;
 
-- 11. Lister chaque ticket pour lequel la quantité totale d’articles vendus est supérieure à 500. (Classer par quantité décroissante)
SELECT CONCAT(ANNEE, " ", NUMERO_TICKET) AS ID_TICKET, SUM(QUANTITE) AS QUANTITE_ARTICLES_VENDUS
FROM ventes
GROUP BY ID_TICKET
HAVING QUANTITE_ARTICLES_VENDUS > 500
ORDER BY QUANTITE_ARTICLES_VENDUS DESC;

-- 12. Lister chaque ticket pour lequel la quantité totale d’articles vendus est supérieure à 500. On exclura du total, les ventes ayant une quantité supérieure à 50 
-- (classer par quantité décroissante)
SELECT CONCAT(ANNEE, " ", NUMERO_TICKET) AS ID_TICKET, SUM(QUANTITE) AS QUANTITE_ARTICLES_VENDUS
FROM ventes
WHERE QUANTITE < 50
GROUP BY ID_TICKET
HAVING QUANTITE_ARTICLES_VENDUS > 500
ORDER BY QUANTITE_ARTICLES_VENDUS DESC;

-- 13. Lister les bières de type ‘Trappiste’. (id, nom de la bière, volume et titrage)
SELECT ID_ARTICLE, NOM_ARTICLE, VOLUME, TITRAGE
FROM article
INNER JOIN type ON article.ID_TYPE = type.ID_TYPE
WHERE NOM_TYPE = 'Trappiste';

-- 14. Lister les marques de bières du continent ‘Afrique’
SELECT NOM_MARQUE
FROM marque
INNER JOIN pays ON marque.ID_PAYS = pays.ID_PAYS
INNER JOIN continent ON pays.ID_CONTINENT = continent.ID_CONTINENT
WHERE NOM_CONTINENT = 'Afrique';

-- 15. Lister les bières du continent ‘Afrique’
SELECT ID_ARTICLE, NOM_ARTICLE, VOLUME
FROM article
INNER JOIN marque ON marque.ID_MARQUE = article.ID_MARQUE
INNER JOIN pays ON marque.ID_PAYS = pays.ID_PAYS
INNER JOIN continent ON pays.ID_CONTINENT = continent.ID_CONTINENT
WHERE NOM_CONTINENT = 'Afrique';

-- 16. Lister les tickets (année, numéro de ticket, montant total payé). En sachant que le prix
-- de vente est égal au prix d’achat augmenté de 15% et que l’on n’est pas assujetti à la TVA.
SELECT CONCAT(ANNEE, " ", NUMERO_TICKET) AS ID_TICKET, ROUND(SUM(PRIX_ACHAT*QUANTITE)*1.15, 2) AS MONTANT_A_PAYER
FROM ventes
INNER JOIN article using(ID_ARTICLE)
GROUP BY ID_TICKET
ORDER BY ID_TICKET;

-- 17. Donner le C.A. par année.
SELECT ANNEE, NOM_MARQUE, ROUND(SUM(PRIX_ACHAT*QUANTITE)*1.15, 2) AS CA
FROM ventes
INNER JOIN article using(ID_ARTICLE)
INNER JOIN marque using(ID_MARQUE)
GROUP BY NOM_MARQUE, ANNEE
ORDER BY NOM_MARQUE; 

-- 18. Lister les quantités vendues de chaque article pour l’année 2016.
SELECT ventes.ID_ARTICLE, NOM_ARTICLE, SUM(QUANTITE) AS VENTES_PAR_ARTICLE, ANNEE
FROM ventes
INNER JOIN article ON ventes.ID_ARTICLE = article.ID_ARTICLE
WHERE ANNEE = 2016
GROUP BY ventes.ID_ARTICLE
ORDER BY ventes.ID_ARTICLE;

-- 19. Lister les quantités vendues de chaque article pour les années 2014, 2015, 2016.
SELECT article.ID_ARTICLE, NOM_ARTICLE, VOLUME, SUM(QUANTITE) AS VENTES_PAR_ARTICLE, ANNEE
FROM ventes
INNER JOIN article ON ventes.ID_ARTICLE = article.ID_ARTICLE
WHERE ANNEE BETWEEN 2014 AND 2016 
GROUP BY article.ID_ARTICLE
ORDER BY NOM_ARTICLE, ANNEE;
  
-- 20. Lister les articles qui n’ont fait l’objet d’aucune vente en 2014.
SELECT article.ID_ARTICLE, NOM_ARTICLE
FROM article
WHERE NOT EXISTS (
	SELECT ventes.ID_ARTICLE
	FROM ventes
	WHERE ventes.ID_ARTICLE = article.ID_ARTICLE
	AND ANNEE = 2014
);

-- 21. Coder de 3 manières différentes la requête suivante : 
-- Lister les pays qui fabriquent des bières de type ‘Trappiste’.

-- 1ère solution
SELECT DISTINCT NOM_PAYS
FROM  pays
INNER JOIN marque ON pays.ID_PAYS = marque.ID_PAYS
INNER JOIN article ON marque.ID_MARQUE = article.ID_MARQUE
INNER JOIN type ON type.ID_TYPE = article.ID_TYPE
WHERE NOM_TYPE = 'Trappiste';

-- 2e solution
SELECT DISTINCT NOM_PAYS
FROM  pays
INNER JOIN marque ON pays.ID_PAYS = marque.ID_PAYS
INNER JOIN article ON marque.ID_MARQUE = article.ID_MARQUE
WHERE ID_TYPE = 13;

-- 3e solution
SELECT DISTINCT NOM_PAYS
FROM  pays
INNER JOIN marque using(ID_PAYS)
INNER JOIN article using(ID_MARQUE)
WHERE ID_TYPE = 13;

-- 22. Lister les tickets sur lesquels apparaissent un des articles apparaissant aussi sur le
-- ticket 2014 856 (le ticket 856 de l'année 2014)
SELECT CONCAT(ANNEE, " ", NUMERO_TICKET) AS ID_TICKET, ID_ARTICLE
FROM ventes
WHERE ID_ARTICLE IN (
	SELECT ID_ARTICLE
    FROM ventes
	WHERE CONCAT(ANNEE, " ", NUMERO_TICKET) = "2014 856"
);

-- 23. Lister les articles ayant un degré d’alcool plus élevé que la plus forte des trappistes.
SELECT NOM_ARTICLE, VOLUME, TITRAGE
FROM article
WHERE TITRAGE > (
	SELECT MAX(TITRAGE)
    FROM article
    WHERE ID_TYPE = 13 # Trappiste
);

-- 24. Editer les quantités vendues pour chaque couleur en 2014.
SELECT SUM(QUANTITE), NOM_COULEUR
FROM ventes
INNER JOIN article using(ID_ARTICLE)
INNER JOIN couleur using(ID_COULEUR)
WHERE ANNEE = 2014
GROUP BY ID_COULEUR;
 
-- 25. Donner pour chaque fabricant, le nombre de tickets sur lesquels apparait un de ses produits en 2014.
SELECT ID_FABRICANT, count(NUMERO_TICKET) AS NB_TICKETS
FROM ventes
INNER JOIN article using(ID_ARTICLE)
INNER JOIN marque using(ID_MARQUE)
WHERE ANNEE = 2014
AND ID_FABRICANT IS NOT NULL
GROUP BY ID_FABRICANT;

-- 26. Donner l’ID, le nom, le volume et la quantité vendue des 20 articles les plus vendus en 2016.
SELECT ID_ARTICLE, NOM_ARTICLE, VOLUME, SUM(QUANTITE) AS QUANTITE_TOTALE
FROM article
INNER JOIN ventes using(ID_ARTICLE)
WHERE ANNEE = 2016
GROUP BY ID_ARTICLE
ORDER BY QUANTITE_TOTALE DESC
LIMIT 20;
 
-- 27. Donner l’ID, le nom, le volume et la quantité vendue des 5 ‘Trappistes’ les plus vendus en 2016.
SELECT ID_ARTICLE, NOM_ARTICLE, VOLUME, SUM(QUANTITE) AS QUANTITE_VENDUE
FROM article
INNER JOIN ventes using(ID_ARTICLE)
WHERE ANNEE = 2016
AND ID_TYPE = 13 # Trappiste
ORDER BY QUANTITE DESC
LIMIT 5;

-- 28. Donner l’ID, le nom, le volume et les quantités vendues en 2015 et 2016, des bières
-- dont les ventes ont été stables. (Moins de 1% de variation)
SELECT ID_ARTICLE, NOM_ARTICLE, VOLUME, QUANTITE
FROM article
INNER JOIN ventes using(ID_ARTICLE)
WHERE ANNEE IN (2015, 2016)
ORDER BY QUANTITE DESC;

SELECT article.ID_ARTICLE, article.NOM_ARTICLE, article.VOLUME, SUM(ventes.QUANTITE) AS QUANTITE_TOTALE FROM article
JOIN (SELECT SUM(QUANTITE) FROM ventes WHERE ANNEE = 2016 GROUP BY ID_ARTICLE) AS SOMME_2016
JOIN (SELECT SUM(QUANTITE) FROM ventes WHERE ANNEE = 2015 GROUP BY ID_ARTICLE) AS SOMME_2015
    INNER JOIN ventes USING (ID_ARTICLE) WHERE ANNEE = 2016 OR ANNEE = 2015
    AND article.ID_ARTICLE = (SELECT ID_ARTICLE FROM ventes HAVING (SOMME_2016-SOMME_2015)/SOMME_2015<0.01) GROUP BY NOM_ARTICLE

-- 29. Lister les types de bières suivant l’évolution de leurs ventes entre 2015 et 2016.
-- Classer le résultat par ordre décroissant des performances.
-- 30. Existe-t-il des tickets sans vente ?
-- 31. Lister les produits vendusen 2016 dans des quantités jusqu’à 15% des quantités de l’article le plus vendu.