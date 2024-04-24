SELECT Species, COUNT(*) AS Nest_Count FROM Bird_nests GROUP BY Species;

-- Calculate the average volume of eggs for each nest
SELECT AVG(Value) AS AverageValue FROM Bird_nests GROUP BY Species;

CREATE TEMP TABLE Averages AS
    SELECT Nest_ID, AVG((3.14/6)*(W^2)*L) AS Avg_volume
    FROM Bird_nests
    GROUP BY Nest_ID;

-- Group nests by species and compute the maximum average volume for each species
CREATE TEMP TABLE MaxAvgVolumes AS
    SELECT Species, MAX(Avg_volume) AS Max_avg_volume
    FROM Bird_nests 
    JOIN Averages USING (Nest_ID)
    GROUP BY Species;

-- Join with the Species table to get scientific names
CREATE TEMP TABLE ScientificNames AS
    SELECT Scientific_name, Max_avg_volume
    FROM MaxAvgVolumes m
    JOIN Species ON Species = Species_code;

-- Order the results in descending order of maximum average volume
SELECT Scientific_name, Max_avg_volume
FROM ScientificNames
ORDER BY Max_avg_volume DESC;

SELECT Scientific_name, COUNT(*) AS Nest_Count FROM Bird_nests GROUP By Species ORDER By Species;