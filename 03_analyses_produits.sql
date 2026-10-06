-- =============================================
-- Projet 5 : Analyse SQL - Base Chinook
-- Étape 3 : Analyses produits
-- Questions 1 et 2 du directeur
-- =============================================

USE chinook;

-- -----------------------------------------------------------
-- Question 1 : qu'est-ce qui se vend ?
-- -----------------------------------------------------------

-- Top 10 des genres de musique qui rapportent le plus
SELECT g.Name                                    AS genre,
       SUM(il.Quantity)                          AS nb_ventes,
       ROUND(SUM(il.UnitPrice * il.Quantity), 2) AS ca
FROM InvoiceLine AS il
JOIN Track AS t USING (TrackId)
JOIN Genre AS g USING (GenreId)
GROUP BY GenreId, g.Name
ORDER BY ca DESC
LIMIT 10;

-- Top 10 des artistes qui rapportent le plus
SELECT ar.Name                                   AS artiste,
       SUM(il.Quantity)                          AS nb_ventes,
       ROUND(SUM(il.UnitPrice * il.Quantity), 2) AS ca
FROM InvoiceLine AS il
JOIN Track  AS t  USING (TrackId)
JOIN Album  AS al USING (AlbumId)
JOIN Artist AS ar USING (ArtistId)
GROUP BY ArtistId, ar.Name
ORDER BY ca DESC
LIMIT 10;

-- -----------------------------------------------------------
-- Question 2 : qu'est-ce qui ne se vend pas, ou peu ?
-- -----------------------------------------------------------

-- Les 5 genres de musique qui rapportent le moins
-- (attention : les genres sans aucune vente, comme l'Opéra, n'apparaissent pas ici)
SELECT g.Name                                    AS genre,
       SUM(il.Quantity)                          AS nb_ventes,
       ROUND(SUM(il.UnitPrice * il.Quantity), 2) AS ca
FROM InvoiceLine AS il
JOIN Track AS t USING (TrackId)
JOIN Genre AS g USING (GenreId)
GROUP BY GenreId, g.Name
ORDER BY ca ASC
LIMIT 5;

-- Nombre de morceaux jamais vendus (résultat : 1 519 sur 3 503)
SELECT COUNT(*) AS nb_morceaux_jamais_vendus
FROM Track AS t
LEFT JOIN InvoiceLine AS il USING (TrackId)
WHERE il.InvoiceLineId IS NULL;

-- Liste des morceaux jamais vendus (avec leur album)
SELECT t.Name   AS titre,
       al.Title AS album
FROM Track AS t
LEFT JOIN InvoiceLine AS il USING (TrackId)
JOIN Album AS al USING (AlbumId)
WHERE il.InvoiceLineId IS NULL
ORDER BY album, titre
LIMIT 20;

-- Taux de rotation par genre : ventes / nombre de morceaux au catalogue
SELECT g.Name                                AS genre,
       COUNT(DISTINCT TrackId)               AS nb_morceaux_catalogue,
       COUNT(il.InvoiceLineId)               AS nb_ventes,
       ROUND(COUNT(il.InvoiceLineId)
             / COUNT(DISTINCT TrackId), 2)   AS taux_rotation
FROM Genre AS g
JOIN Track AS t USING (GenreId)
LEFT JOIN InvoiceLine AS il USING (TrackId)
GROUP BY GenreId, g.Name
ORDER BY taux_rotation ASC
LIMIT 5;
