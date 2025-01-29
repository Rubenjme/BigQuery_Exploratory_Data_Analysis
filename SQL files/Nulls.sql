-- Valores nulos para la tabla features
SELECT
    COUNTIF(CPI IS NULL) AS Null_CPI,
    COUNTIF(Unemployment IS NULL) AS Null_Unemployment,
    COUNTIF(Store IS NULL) AS Null_Stores,
    COUNTIF(Date IS NULL) AS Null_Dates,
    COUNTIF(Temperature IS NULL) AS Null_Temperatures,
    COUNTIF(Fuel_Price IS NULL) AS Null_FuelPrices,
    COUNTIF(IsHoliday IS NULL) AS Null_IsHoliday,
    COUNTIF(MarkDown1 IS NULL) AS Null_Markdown1,
    COUNTIF(MarkDown2 IS NULL) AS Null_Markdown2,
    COUNTIF(MarkDown3 IS NULL) AS Null_Markdown3,
    COUNTIF(MarkDown4 IS NULL) AS Null_Markdown4,
    COUNTIF(MarkDown5 IS NULL) AS Null_Markdown5
FROM `Data_Queries.features`;

-- Valores nulos para la tabla sales
SELECT
    COUNTIF(Store IS NULL) AS Null_StoresSales,
    COUNTIF(Date IS NULL) AS Null_Dates,
    COUNTIF(Dept IS NULL) AS Null_Dept,
    COUNTIF(Weekly_Sales IS NULL) AS Null_WeeklySales,
    COUNTIF(IsHoliday IS NULL) AS Null_IsHoliday
FROM `Data_Queries.sales`;

-- Valores nulos para la tabla stores
SELECT
    COUNTIF(Store IS NULL) AS Null_Stores,
    COUNTIF(Type IS NULL) AS Null_Type,
    COUNTIF(Size IS NULL) AS Null_Size
FROM `Data_Queries.stores`;

# Valores anómalos
SELECT * FROM `Data_Queries.features` 
WHERE Temperature < 15 OR Temperature > 40 
ORDER BY Store;

SELECT * FROM `Data_Queries.sales` 
WHERE Weekly_Sales < 0 
ORDER BY Weekly_Sales;
