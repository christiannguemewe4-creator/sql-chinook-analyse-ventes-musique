-- Projet 5 : Analyse SQL - Base Chinook
-- Étape 1 : Exploration de la base
USE CHINOOK;
-- 1. Liste des tables
SHOW tables;
-- 2. Structure des tables principales
DESCRIBE Customer;
DESCRIBE Invoice;
DESCRIBE InvoiceLine;
DESCRIBE Track;
-- 3. Aperçu des données
SELECT * FROM Customer LIMIT 5;
SELECT * FROM Invoice LIMIT 5;
SELECT * FROM InvoiceLine LIMIT 5;
-- 4. Période couverte par les ventes
SELECT MIN(InvoiceDate) AS premiere_vente,
       MAX(InvoiceDate) AS derniere_vente
FROM Invoice;


