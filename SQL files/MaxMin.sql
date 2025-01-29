-- Máximos y mínimos de cada variable numérica
SELECT MIN(Size) AS min_size, MAX(Size) AS max_size FROM `Data_Queries.stores`;

SELECT MIN(Temperature) AS MinTemp, MAX(Temperature) AS MaxTemp,
       MIN(Fuel_Price) AS MinFuel, MAX(Fuel_Price) AS MaxFuel,
       MIN(Unemployment) AS MinUnemployment, MAX(Unemployment) AS MaxUnemployment,
       MIN(CPI) AS MinCPI, MAX(CPI) AS MaxCPI
FROM `Data_Queries.features`;

SELECT MIN(Weekly_Sales) AS MinSales, MAX(Weekly_Sales) AS MaxSales FROM `Data_Queries.sales`;
