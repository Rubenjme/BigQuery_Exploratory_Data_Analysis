-- Valores anómalos
SELECT * FROM `Data_Queries.features` 
WHERE Temperature < 14 OR Temperature > 95  --Grados Fahrenheit (Menor a -10ºC y mayor a 35ºC )
ORDER BY Store;

SELECT * FROM `Data_Queries.sales` 
WHERE Weekly_Sales < 0 
ORDER BY Weekly_Sales;

