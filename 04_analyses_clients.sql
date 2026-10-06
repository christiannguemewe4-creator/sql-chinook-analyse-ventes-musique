-- =============================================
-- Projet 5 : Analyse SQL - Base Chinook
-- Étape 4 : Analyses clients
-- Questions 3 et 4 du directeur
-- =============================================

USE chinook;

-- -----------------------------------------------------------
-- Question 3 : où sont nos clients et combien dépensent-ils ?
-- -----------------------------------------------------------

-- Nombre de clients par pays
SELECT Country                    AS pays,
       COUNT(DISTINCT CustomerId) AS nb_clients
FROM Customer
GROUP BY Country
ORDER BY nb_clients DESC;

-- Panier moyen par pays (montant moyen d'une facture)
SELECT Country              AS pays,
       ROUND(AVG(Total), 2) AS panier_moyen
FROM Customer
JOIN Invoice USING (CustomerId)
GROUP BY Country
ORDER BY panier_moyen DESC;

-- Chiffre d'affaires par client, par pays
SELECT Country                                           AS pays,
       COUNT(DISTINCT CustomerId)                        AS nb_clients,
       ROUND(SUM(Total) / COUNT(DISTINCT CustomerId), 2) AS ca_par_client
FROM Customer
JOIN Invoice USING (CustomerId)
GROUP BY Country
ORDER BY ca_par_client DESC;

-- -----------------------------------------------------------
-- Question 4 : meilleurs clients et clients inactifs
-- -----------------------------------------------------------

-- Top 5 des meilleurs clients
SELECT FirstName            AS prenom,
       LastName             AS nom,
       Country              AS pays,
       ROUND(SUM(Total), 2) AS total_achats
FROM Customer
JOIN Invoice USING (CustomerId)
GROUP BY CustomerId, FirstName, LastName, Country
ORDER BY total_achats DESC
LIMIT 5;

-- Clients qui ont arrêté d'acheter
-- (référence : 22/12/2025, dernière vente de la base)
SELECT FirstName                                AS prenom,
       LastName                                 AS nom,
       Country                                  AS pays,
       DATE(MAX(InvoiceDate))                   AS dernier_achat,
       DATEDIFF('2025-12-22', MAX(InvoiceDate)) AS jours_sans_achat
FROM Customer
JOIN Invoice USING (CustomerId)
GROUP BY CustomerId, FirstName, LastName, Country
ORDER BY jours_sans_achat DESC
LIMIT 15;
