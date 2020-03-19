-- 1. Quels sont les tickets qui comportent l’article d’ID 500, afficher le numéro de ticket uniquement ?
SELECT NUMERO_TICKET FROM ventes
WHERE ID_ARTICLE = 500;

-- 2. Afficher les tickets du 15/01/2014.
SELECT NUMERO_TICKET FROM ticket
WHERE DATE_VENTE = "2014-01-15";

-- 3. Afficher les tickets émis du 15/01/2014 et le 17/01/2014.
SELECT NUMERO_TICKET, DATE_VENTE FROM ticket
WHERE DATE_VENTE = "2014-01-15" OR DATE_VENTE = "2014-01-17";

-- 4. Editer la liste des articles apparaissant
-- à 50 et plus exemplaires sur un ticket.
-- 5. Quelles sont les tickets émis au mois de mars 2014.
-- 6. Quelles sont les tickets émis entre les mois de mars et avril 2014 ?
-- 7. Quelles sont les tickets émis au mois de mars et juin 2014 ?
-- 8. Afficher la liste des bières classée par couleur. ( A fficher l’id et le nom)
-- 9. Afficher la liste des bières n’ayant pas de couleur. (Afficher l’id et le nom)
-- 10. Lister pour chaque ticket la quantité totale d’articles vendus. (Classer par quantité décroissante)
-- 11. Lister chaque ticket pour lequel la quantité totale d’articles vendus est supérieure à 500. ( C lasser par quantité décroissante)