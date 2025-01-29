-- Creo una vista de Ventas en función de las vacaciones
CREATE OR REPLACE VIEW `Data_Queries.sales_holiday_analysis` AS
SELECT
    s.Store,
    ROUND(SUM(CASE WHEN s.IsHoliday = TRUE THEN s.Weekly_Sales ELSE 0 END), 2) AS Total_Sales_Holiday,
    ROUND(SUM(CASE WHEN s.IsHoliday = FALSE THEN s.Weekly_Sales ELSE 0 END), 2) AS Total_Sales_NoHoliday,
    COUNT(CASE WHEN s.IsHoliday = TRUE THEN 1 ELSE NULL END) AS Holiday_Weeks,
    COUNT(CASE WHEN s.IsHoliday = FALSE THEN 1 ELSE NULL END) AS NoHoliday_Weeks,
    ROUND(SUM(CASE WHEN s.IsHoliday = TRUE THEN s.Weekly_Sales ELSE 0 END) / COUNT(CASE WHEN s.IsHoliday = TRUE THEN 1 ELSE NULL END), 2) AS Avg_Sales_Holiday,
    ROUND(SUM(CASE WHEN s.IsHoliday = FALSE THEN s.Weekly_Sales ELSE 0 END) / COUNT(CASE WHEN s.IsHoliday = FALSE THEN 1 ELSE NULL END), 2) AS Avg_Sales_NoHoliday,
    ROUND((SUM(CASE WHEN s.IsHoliday = TRUE THEN s.Weekly_Sales ELSE 0 END) / COUNT(CASE WHEN s.IsHoliday = TRUE THEN 1 ELSE NULL END)) / 
    (SUM(CASE WHEN s.IsHoliday = FALSE THEN s.Weekly_Sales ELSE 0 END) / COUNT(CASE WHEN s.IsHoliday = FALSE THEN 1 ELSE NULL END)) * 100, 2) AS Holiday_vs_NoHoliday_Percentage
FROM
    'Data_Queries.sales' s
GROUP BY
    s.Store
ORDER BY
    s.Store;
    

SELECT * FROM `Data_Queries.sales_holiday_analysis`