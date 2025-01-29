-- Variables categóricas
SELECT IsHoliday, COUNT(*) AS count
FROM `Data_Queries.features`
GROUP BY IsHoliday ORDER BY count DESC;

SELECT Type, COUNT(*) AS count
FROM `Data_Queries.stores`
GROUP BY Type ORDER BY count DESC;

SELECT Dept, COUNT(*) AS count
FROM `Data_Queries.sales`
GROUP BY Dept ORDER BY count DESC;
