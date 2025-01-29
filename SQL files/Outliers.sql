-- Valores anómalos
SELECT * FROM `Data_Queries.features` 
WHERE Temperature < 15 OR Temperature > 40 
ORDER BY Store;

SELECT * FROM `Data_Queries.sales` 
WHERE Weekly_Sales < 0 
ORDER BY Weekly_Sales;