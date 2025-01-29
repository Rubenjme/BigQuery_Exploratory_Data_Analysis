-- Creo una vista de "Ventas por tipo de tienda"
CREATE OR REPLACE VIEW `Data_Queries.sales_by_store_type` AS
SELECT  
    s.Store,  -- ID de la tienda
    st.Type,  -- Tipo de tienda
    ROUND(SUM(s.Weekly_Sales), 2) AS Total_Sales,  -- Suma de ventas semanales, redondeada a 2 decimales.
    ROUND(AVG(s.Weekly_Sales), 2) AS Avg_Sales     -- Media de ventas semanales, redondeada a 2 decimales.
FROM `Data_Queries.sales` s  
JOIN `Data_Queries.stores` st  
ON  
    s.Store = st.Store  
WHERE s.Weekly_Sales >= 0  
GROUP BY  
    s.Store, st.Type  
ORDER BY  
    Total_Sales DESC;  



SELECT * FROM `Data_Queries.sales_by_store_type`;   -- Consulto la vista creada
