CREATE TABLE road_accidents (
    accident_index VARCHAR(50) PRIMARY KEY,
    accident_date DATE,
    day_of_week VARCHAR(50),
    junction_control VARCHAR(50),
    junction_detail VARCHAR(50),
    accident_severity VARCHAR(50),
    light_conditions VARCHAR(50),
    local_authority VARCHAR(50),
    carriageway_hazards VARCHAR(50),
    number_of_casualties INT,
    number_of_vehicles INT,
    police_force VARCHAR(50),
    road_surface_conditions VARCHAR(50),
    road_type VARCHAR(50),
    speed_limit INT,
    time TIME,
    urban_or_rural_area VARCHAR(50),
    weather_conditions VARCHAR(50),
    vehicle_type VARCHAR(50)
);

select * from road_accidents;

ALTER TABLE road_accidents 
ALTER COLUMN day_of_week TYPE VARCHAR(50);
ALTER TABLE road_accidents 
ALTER COLUMN accident_severity TYPE VARCHAR(50),
ALTER COLUMN urban_or_rural_area TYPE varchar(50);

SELECT SUM(number_of_casualties) AS CY_casualties
FROM road_accidents
WHERE EXTRACT(YEAR FROM accident_date) = 2022 ;

select count(distinct accident_index) as CY_accidents
from road_accidents
where extract(year from accident_date)=2022;

SELECT SUM(number_of_casualties) AS CY_fatal_casualties
FROM road_accidents
WHERE EXTRACT(YEAR FROM accident_date) = 2022 and accident_severity='Fatal' ;

-- What are the number of casualties in each day of the week? Sort them in descending order.
SELECT
  SUM(Number_of_Casualties) AS Total_Casualties
FROM
  road_accidents 
GROUP BY
  Day_of_Week
ORDER BY
  Total_Casualties DESC;


-- Which geographic areas have the highest occurrence of accidents?
SELECT 
    urban_or_rural_area, 
    SUM(Number_of_Casualties) AS Total_Casualties
FROM 
    road_accidents
GROUP BY 
    urban_or_rural_area
ORDER BY 
    Total_Casualties DESC
LIMIT 10;

-- What are the most frequent weather conditions associated with accidents?
SELECT 
    Weather_Conditions, 
    COUNT(*) AS Num_Accidents
FROM 
    road_accidents
GROUP BY 
    Weather_Conditions
ORDER BY 
    Num_Accidents DESC;

-- What are the most common types of vehicles involved in accidents?
SELECT 
    Vehicle_Type, 
    COUNT(*) AS Num_Accidents
FROM 
    road_accidents
GROUP BY 
    Vehicle_Type
ORDER BY 
    Num_Accidents DESC;

-- How do the number of casualties vary across different types of accidents?
SELECT 
    Accident_Severity, 
    Road_Type, 
    COUNT(*) AS Num_Accidents, 
    SUM(Number_of_Casualties) AS Num_Casualties
FROM 
    road_accidents
GROUP BY 
    Accident_Severity, Road_Type
ORDER BY 
    Accident_Severity ASC, Num_Casualties DESC;

-- Quantity and ratio of severity.
SELECT 
	accident_severity,
	COUNT(accident_severity) AS total_severity,
	ROUND(COUNT(*) * 100./ SUM(COUNT(*)) OVER (),2) as percentage_of_accidents
from
	road_accidents
GROUP BY accident_severity
ORDER BY 3 DESC;

-- Verify if most accidents happens during the night or day.
SELECT 
    Light_Conditions, 
    COUNT(*) AS Num_Accidents
FROM 
    road_accidents
WHERE 
    Light_Conditions IN ('Daylight', 'Darkness - lights lit', 'Darkness - no lighting', 'Darkness - lighting unknown', 'Darkness - lights unlit')
GROUP BY 
    Light_Conditions
ORDER BY 
    Num_Accidents DESC;






