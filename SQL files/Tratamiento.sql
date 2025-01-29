-- Limpieza y reestructuración de datos
CREATE OR REPLACE TABLE `Data_Queries.features` AS SELECT
    Store,
    Date,
    Temperature,
    Fuel_Price,
    SAFE_CAST(NULLIF(MarkDown1, 'NA') AS FLOAT64) AS MarkDown1,
    SAFE_CAST(NULLIF(MarkDown2, 'NA') AS FLOAT64) AS MarkDown2,
    SAFE_CAST(NULLIF(MarkDown3, 'NA') AS FLOAT64) AS MarkDown3,
    SAFE_CAST(NULLIF(MarkDown4, 'NA') AS FLOAT64) AS MarkDown4,
    SAFE_CAST(NULLIF(MarkDown5, 'NA') AS FLOAT64) AS MarkDown5,
    SAFE_CAST(NULLIF(CPI, 'NA') AS FLOAT64) AS CPI,
    SAFE_CAST(NULLIF(Unemployment, 'NA') AS FLOAT64) AS Unemployment,
    IsHoliday
FROM
    `Data_Queries.features`;



