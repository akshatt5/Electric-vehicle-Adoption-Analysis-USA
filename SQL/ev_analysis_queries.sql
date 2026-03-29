USE ev_analysis_project;
-- EV TABLE
CREATE TABLE IF NOT EXISTS ev_registrations (
    State VARCHAR(100),
    EV_Registrations INT,
    registration_year INT);
-- VEHICLE TABLE
CREATE TABLE vehicle_registrations_full (
    State VARCHAR(100),
    Automobiles_Private_Commercial_Including_Taxicabs INT,
    Automobiles_Publicly_Owned INT,
    Automobiles_Total INT,
    Buses_Private_Commercial INT,
    Buses_Publicly_Owned INT,
    Buses_Total INT,
    Trucks_Private_Commercial INT,
    Trucks_Publicly_Owned INT,
    Trucks_Total INT,
    Motorcycles_Private_Commercial INT,
    Motorcycles_Publicly_Owned INT,
    Motorcycles_Total INT,
    All_Motor_Vehicles_Private_Commercial INT,
    All_Motor_Vehicles_Publicly_Owned INT,
    All_Motor_Vehicles_Total INT);
    SELECT * FROM vehicle_registrations_fullAutomobiles_Publicly_Owned LIMIT 10;
    
-- 🔹 Total EV registrations
SELECT 
     SUM(EV_Registrations) AS Total_EV_Registrations
FROM ev_registrations;

-- 🔹 Top 10 states by EV registrations
SELECT
   State,EV_Registrations
FROM ev_registrations
ORDER BY EV_Registrations DESC
LIMIT 10;

-- 🔹 Bottom 10 states by EV registrations
SELECT 
    State, EV_Registrations
FROM ev_registrations
ORDER BY EV_Registrations ASC
LIMIT 10;

-- 🔹 Year-wise EV growth
SELECT
    registration_year,
    SUM(EV_Registrations) AS Total_EV
FROM ev_registrations
GROUP BY registration_year
ORDER BY registration_year;

-- 🔹 Vehicle segmentation
SELECT 
State, Automobiles_Total,
Buses_Total, Trucks_Total,
Motorcycles_Total, All_Motor_Vehicles_Total
FROM vehicle_registrations_full
ORDER BY All_Motor_Vehicles_Total DESC;

-- 🔹 Total vehicle categories
SELECT
 SUM(Automobiles_Total) AS Total_Automobiles,
SUM(Buses_Total) AS Total_Buses,
SUM(Trucks_Total) AS Total_Trucks,
SUM(Motorcycles_Total) AS Total_Motorcycles,
SUM(All_Motor_Vehicles_Total) AS Total_All_Vehicles
FROM vehicle_registrations_full;

-- 🔹 Top states by total vehicles
SELECT 
State,
All_Motor_Vehicles_Total
FROM vehicle_registrations_full
ORDER BY All_Motor_Vehicles_Total DESC
LIMIT 10;

-- 🔹 Private vs Public (state-wise)
SELECT 
State,
All_Motor_Vehicles_Private_Commercial AS Private_Vehicles,
All_Motor_Vehicles_Publicly_Owned AS Public_Vehicles,
All_Motor_Vehicles_Total AS Total_Vehicles
FROM vehicle_registrations_full
ORDER BY Total_Vehicles DESC;

-- 🔹 EV share %
SELECT
 e.State,
e.EV_Registrations,
v.All_Motor_Vehicles_Total,
ROUND((e.EV_Registrations / v.All_Motor_Vehicles_Total) * 100, 2) AS EV_Share_Percentage
FROM ev_registrations e
JOIN vehicle_registrations_full v
ON e.State = v.State
ORDER BY EV_Share_Percentage DESC;

-- 🔹 Top 10 EV share states
SELECT 
e.State,
ROUND((e.EV_Registrations / v.All_Motor_Vehicles_Total) * 100, 2) AS EV_Share_Percentage
FROM ev_registrations e
JOIN vehicle_registrations_full v
ON e.State = v.State
ORDER BY EV_Share_Percentage DESC
LIMIT 10;

-- 🔹 Lowest EV adoption states
SELECT 
e.State,
ROUND((e.EV_Registrations / v.All_Motor_Vehicles_Total) * 100, 2) AS EV_Share_Percentage
FROM ev_registrations e
JOIN vehicle_registrations_full v
ON e.State = v.State
ORDER BY EV_Share_Percentage ASC
LIMIT 10;