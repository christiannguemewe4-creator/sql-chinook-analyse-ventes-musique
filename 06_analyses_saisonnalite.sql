-- =============================================
-- Projet 5 : Analyse SQL - Base Chinook
-- Étape 6 : Saisonnalité des ventes

USE chinook;

 -- y a-t-il des mois meilleurs que d'autres ?
SELECT MONTH(InvoiceDate)   AS mois,
       COUNT(*)             AS nb_factures,
       ROUND(SUM(Total), 2) AS ca
FROM Invoice
GROUP BY mois
ORDER BY mois;

SELECT e.FirstName                                         AS prenom,
       e.LastName                                          AS nom,
       COUNT(DISTINCT CustomerId)                          AS nb_clients,
       COUNT(*)                                            AS nb_factures,
       ROUND(SUM(Total), 2)                                AS ca,
       ROUND(SUM(Total) / COUNT(DISTINCT CustomerId), 2)   AS ca_par_client
FROM Employee AS e
JOIN Customer  using(EmployeeId)
JOIN Invoice USING (CustomerId)
GROUP BY e.EmployeeId, e.FirstName, e.LastName
ORDER BY ca DESC;

--  quel employé du support génère le plus de chiffre d'affaires ?
SELECT e.FirstName                                       AS prenom,
       e.LastName                                        AS nom,
       COUNT(DISTINCT CustomerId)                        AS nb_clients,
       COUNT(*)                                          AS nb_factures,
       ROUND(SUM(Total), 2)                              AS ca,
       ROUND(SUM(Total) / COUNT(DISTINCT CustomerId), 2) AS ca_par_client
FROM Employee AS e
JOIN Customer AS c ON c.SupportRepId = e.EmployeeId
JOIN Invoice USING (CustomerId)
GROUP BY e.EmployeeId, e.FirstName, e.LastName
ORDER BY ca DESC;

