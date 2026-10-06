-- =============================================
-- Projet 5 : Analyse SQL - Base Chinook
-- Étape 2 : Analyses de base
-- =============================================

USE chinook;

-- 1. Chiffres clés globaux
SELECT COUNT(*)             AS nb_factures,
       ROUND(SUM(Total), 2) AS ca_total,
       ROUND(AVG(Total), 2) AS panier_moyen
FROM Invoice;

-- 2. Chiffre d'affaires par année
SELECT YEAR(InvoiceDate)    AS annee,
       COUNT(*)             AS nb_factures,
       ROUND(SUM(Total), 2) AS ca
FROM Invoice
GROUP BY annee
ORDER BY annee;

-- 3. Top 10 des pays par chiffre d'affaires
SELECT BillingCountry       AS pays,
       COUNT(*)             AS nb_factures,
       ROUND(SUM(Total), 2) AS ca
FROM Invoice
GROUP BY BillingCountry
ORDER BY ca DESC
LIMIT 10;

-- 4. Top 5 des meilleurs clients
SELECT FirstName            AS prenom,
       LastName             AS nom,
       Country              AS pays,
       ROUND(SUM(Total), 2) AS total_achats
FROM Customer
JOIN Invoice USING (CustomerId)
GROUP BY CustomerId, FirstName, LastName, Country
ORDER BY total_achats DESC
LIMIT 5;
