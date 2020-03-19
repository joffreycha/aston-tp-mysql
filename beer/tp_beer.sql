-- 1. Quels sont les tickets qui comportent l’article d’ID 500, afficher le numéro de ticket uniquement ?
SELECT NUMERO_TICKET FROM ventes
WHERE ID_ARTICLE = 500;

-- 2. Afficher les tickets du 15/01/2014.
SELECT NUMERO_TICKET FROM ticket
WHERE DATE_VENTE = "2014-01-15";

-- 3. Afficher les tickets émis le 15/01/2014 et le 17/01/2014.
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
SELECT ventes.NUMERO_TICKET, ROUND(SUM(PRIX_ACHAT)*1.15, 2) AS MONTANT_A_PAYER
FROM ventes
INNER JOIN article ON article.ID_ARTICLE = ventes.ID_ARTICLE
GROUP BY ventes.NUMERO_TICKET
ORDER BY ventes.NUMERO_TICKET;

-- 17. Donner le C.A. par année.
SELECT ANNEE, ROUND(SUM(PRIX_ACHAT)*1.15, 2) AS CA
FROM ventes
INNER JOIN article ON article.ID_ARTICLE = ventes.ID_ARTICLE
GROUP BY ventes.ANNEE
ORDER BY ventes.ANNEE; 

-- 18. Lister les quantités vendues de chaque article pour l’année 2016.
SELECT ventes.ID_ARTICLE, NOM_ARTICLE, SUM(QUANTITE) AS VENTES_PAR_ARTICLE, ANNEE
FROM ventes
INNER JOIN article ON ventes.ID_ARTICLE = article.ID_ARTICLE
WHERE ANNEE = 2016
GROUP BY ventes.ID_ARTICLE
ORDER BY ventes.ID_ARTICLE;

-- 19. Lister les quantités vendues de chaque article pour les années 2014, 2015, 2016.
SELECT ventes.ID_ARTICLE, NOM_ARTICLE, SUM(QUANTITE) AS VENTES_PAR_ARTICLE, ANNEE
FROM ventes
INNER JOIN article ON ventes.ID_ARTICLE = article.ID_ARTICLE
WHERE ANNEE BETWEEN 2014 AND 2016
GROUP BY ventes.ID_ARTICLE
ORDER BY ANNEE, ventes.ID_ARTICLE;

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
SELECT *
FROM ticket
WHERE EXISTS(
	SELECT ID_ARTICLE FROM ventes
	WHERE ANNEE = 2014
	AND NUMERO_TICKET = 856
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


-- 25. Donner pour chaque fabricant, le nombre de tickets sur lesquels apparait un de ses produits en 2014.
-- 26. Donner l’ID, le nom, le volume et la quantité vendue des 20 articles les plus vendus en 2016.
-- 27. Donner l’ID, le nom, le volume et la quantité vendue des 5 ‘Trappistes’ les plus vendus en 2016.
-- 28. Donner l’ID, le nom, le volume et les quantités vendues en 2015 et 2016, des bières
-- dont les ventes ont été st ables. ( Moins de 1% de variation)
-- 29. Lister les types de bières suivant l’évolution de leurs ventes entre 2015 et 2016.
-- Classer le résultat par ordre décroissant des performances.
-- 30. Existe-t-il des tickets sans vente ?
-- 31. Lister les produits vendusen 2016 dans des quantités jusqu’à 15% des quantités de l’article le plus vendu.