-- PART 1 --

-- Create table
CREATE TEMP TABLE mytable (VALUE REAL);

-- Insert real numbers and two NULL values into table
INSERT INTO mytable (Value) VALUES (33.2), (20.1), (NULL), (15.0), (NULL);

-- Display to check that table worked
SELECT * FROM mytable;

-- try taking the average
SELECT AVG(Value) AS AverageValue FROM mytable;

--ANSWER TO PART 1---
-- the resulting average is 22.766, which tells me that the SQL ignores NULL values and calculates the average from the REAL values only. 


-- PART 2 --
SELECT SUM(Value)/COUNT(*) FROM mytable;
SELECT SUM(Value)/COUNT(Value) FROM mytable;

-- ANSWER TO PART 2
-- the second SQL code is correct. The difference is that the first code replaces NULL values with a zero, which brings the average lower, while the second SQL code ignores NULL values and gets the accurate average of 22.766. 

