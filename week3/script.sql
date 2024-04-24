.maxrow 6
SELECT Location FROM Site;
SELECT * FROM Site WHERE Area < 200;
SELECT * FROM SITE WHERE Area <200 AND Locatio LIKE '%USA';
--expressions
SELECT Site_name, Area FROM Site;
SELECT Site_name, Area*2.47 FROM Site;
SELECT Site_name, Area*2.47 AS Area_acres FROM Site;
SELECT Site_name || 'foo' from Site;
--- aggregation function
SELECT COUNT(*) FROM Site;
SELECT COUNT(*) AS num_rows FROM Site;
.mode duckbox
SELECT COUNT(Scientific_name) FROM Species;
SELECT DISTINCT Relevance FROM Species;
-- MIN, MAX, AVG
SELECT AVG(Area) FROM Site;
--grouping
SELECT * FROM Site;
SELECT Location, MAX(Area)
    FROM Site
    GROUP BY Location;
--find how many sites by location
SELECT Location, COUNT(*)
    FROM Site
    GROUP BY Location;

SELECT Relevance, COUNT(Scientific_name)
    GROUP BY Location;

--like makes it case sensitive
SELECT Location, MAX(Area)
    FROM Site
    WHERE Location LIKE '%Canada' 
    GROUP BY Location;

--the order of commands matter; start with maximum
SELECT Location, MAX(Area) AS Max_area
    FROM Site
    WHERE Location LIKE '%Canada'
    GROUP BY Location
    HAVING Max_area > 200;

-- relational algebra peeks through! you can call other tables
SELECT COUNT(*) FROM Site;
SELECT COUNT(*) FROM (SELECT COUNT(*)FROM Site);
SELECT * FROM Bird_nests LIMIT 3;
SELECT COUNT(*) FROM Species;
SELECT * FROM Species
    WHERE Code NOT IN (SELECT DISTINCT Species FROM Bird_nests);

-- saving your queries!
CREATE TEMP TABLE t AS
    SELECT * FROM Species
        WHERE Code NOT IN (SELECT DISTINCT Species FROM Bird_nests);
-- now you can call from your temporary table, which disappears when you exit out of duckdb
SELECT * FROM t;
-- what if you want to save it to duckdb permanently?
CREATE TABLE t_perm AS
    SELECT * FROM Species
        WHERE Code NOT IN (SELECT DISTINCT Species FROM Bird_nests);
SELECT * FROM t_perm;
--deleting the perm table
DROP TABLE t_perm;

--NULL PROCESSING (Not known)

-- try to do operation where ages are less than or equal to 5; not true or false, it's null (I don't know)
SELECT COUNT(*) FROM Bird_nests
    WHERE floatAge <= 5;
SELECT COUNT(*) FROM Bird_nests;
-- this won't work because it is an operation
SELECT COUNT(*) FROM Bird_nests WHERE floatAge = NULL;
-- this works because it's a defintion (HW!)
SELECT COUNT(*) FROM Bird_nests WHERE floatAge IS NULL;

-- joins
-- link camp to personnel bc there's a foreign key in that table linking to personnel
-- join because you want the full name instead of abbreviation
-- note when joining, you are always creating a table with all columns, which means duplicates (now temp denormalized)
SELECT * FROM Camp_assignment;
SELECT * FROM Personnel;
SELECT * FROM Camp_assignment join Personnel
    ON Observer = Abbreviation;
.mode csv 
SELECT * FROM Camp_assignment join Personnel
    ON Observer = Abbreviation
    LIMIT 3;

-- go back to nice table view
.mode duckbox

-- you can also specify which table column you want
SELECT * FROM Camp_assignment join Personnel
    ON Camp_assignment.Observer = Personnel.Abbreviation;

-- you can abbreviate the table name to make code nicer
SELECT * FROM Camp_assignment AS ca join Personnel p
    ON ca.Observer = p.Abbreviation;

-- multiway join with relationship defined in "on" line
SELECT * FROM Camp_assignment AS ca join Personnel p
    ON ca.Observer = p.Abbreviation
    JOIN Site s
    ON ca.Site = s.Code
    LIMIT 3;

-- add more clauses to filter, order, group, etc
SELECT * FROM Camp_assignment AS ca join Personnel p
    ON ca.Observer = p.Abbreviation
    JOIN Site s
    ON ca.Site = s.Code
    WHERE ca.Observer = 'lmckinnon'
    LIMIT 3;

-- order by: at end
SELECT * FROM Camp_assignment AS ca join Personnel p

    ON ca.Observer = p.Abbreviation
    JOIN Site s
    ON ca.Site = s.Code
    WHERE ca.Observer = 'lmckinnon'
    LIMIT 3;

-- more on grouping
SELECT Nest_ID, COUNT(*) FROM Bird_eggs GROUP BY Nest_ID;