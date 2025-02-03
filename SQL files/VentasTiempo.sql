-- Creo una vista de "Ventas a lo largo del tiempo"
CREATE OR REPLACE VIEW `Data_Queries.sales_over_time` AS
SELECT  
    s.Date,
    s.Store,  
    Round(SUM(s.Weekly_Sales),2) AS Total_Sales,  
    Round(AVG(s.Weekly_Sales),2) AS Avg_Sales  
FROM  
    `Data_Queries.sales` s  
WHERE s.Weekly_Sales >= 0  
GROUP BY  
    s.Date,
    s.Store  
ORDER BY  
    s.Date,
    s.Store;  

select * from `Data_Queries.sales_over_time`;  -- Consulto la vista creada
