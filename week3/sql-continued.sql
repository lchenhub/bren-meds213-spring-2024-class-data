.tables
SELECT Nest_ID, COUNT(*) FROM Bird_nests
    GROUP BY Nest_ID;

SELECT Species, COUNT(*) AS Nest_Count
    FROM Bird_nests
    WHERE Site = "none"
    GROUP By Species
    ORDER By Species
    LIMIT 2) JOIN Species ON Species = Code;

--can nest queries
SELECT Scientific_name, COUNT(*) AS Nest_Count
    FROM Bird_nests
    WHERE Site = "none"
    GROUP By Species
    ORDER By Species
    LIMIT 2) JOIN Species ON Species = Code;

--- outer joins
CREATE TEMP Table a (cola INTEGER, common INTEGER);
INSERT INTO a VALUES (1,1), (2,2), (3,3);
SELECT * FROM a;
CREATE TEMP TABLE b (common INTEGER, colb INTEGER);
INSERT INTO b VALUES (2,2), (3,3), (4,4), (5,5);
SELECT * FROM b;
--- inner join
SELECT * FROM a JOIN B Using (common);
SELECT * FROM a INNER JOIN b USING (common);
--left or right outer join
SELECT * FROM a LEFT JOIN b USING (common);
--- you can set null value to display as NULL for this session, to be more specific
.nullvalue -NULL-
.nullvalue ""
SELECT * FROM a RIGHT JOIN b USING (common);
-- What species do *not* have nest data?
SELECT * FROM Species 
    WHERE Code NOT IN (SELECT DISTINCT Species FROM Bird_nests);

-- Let's do the same using an outer join
SELECT Code, Scientific_name, Nest_ID, Species, Year
    FROM Species LEFT JOIN Bird_nests ON Code = Species;
.nullvalue -NULL-
SELECT COUNT(*) FROM Bird_nests WHERE Species = 'ruff';
SELECT Code, Scientific_name, Nest_ID, Species, YEAR
    FROM Species LEFT JOIN Bird_nests ON Code = Species
    WHERE NEST_ID IS NULL;
--a gotcha when doing grouping
SELECT * FROM Bird_eggs LIMIT 3;
SELECT * FROM Bird_nests JOIN Bird_eggs USING (Nest_ID)
    WHERE NEST_ID = '14eabaagel01';
SELECT NEST_ID, COUNT(*)
    FROM Bird_nests JOIN Bird_eggs USING (Nest_ID)
    WHERE Nest_ID = '14eabaage01'
    GROUP BY Nest_ID;
-- What about this now?
SELECT Nest_ID, Species, COUNT (*)
    FROM Bird_nests JOIN Bird_eggs USING (Nest_ID)
    WHERE Nest_ID = '14eabaage01';
-- workaround #1
SELECT Nest_ID, Species, COUNT (*)
    FROM Bird_nests JOIN Bird_eggs USING (Nest_ID)
    WHERE Nest_ID = '14eabaage01';
    GROUP BY Nest_ID, Species;
-- workaround #2
SELECT Nest_ID, ANY_VALUE(Species), COUNT (*)
    FROM Bird_nests JOIN Bird_eggs USING (Nest_ID)
    WHERE Nest_ID = '14eabaage01';
    GROUP BY Nest_ID, Species;
-- views
SELECT * FROM Camp_Assignment;
SELECT Year, Site, Name, Start, "End"
    FROM Camp_Assignment JOIN Personnel
    ON Observer = Abbreviation;
Create VIEW v AS
    SELECT Year, Site, Name, Start, "End"
    FROM Camp_Assignment JOIN Personnel
    ON Observer = Abbreviation;
-- a view looks just like a table, but it's not real
SELECT * FROM v;
CREATE VIEW v2 AS SELECT COUNT (*) FROM Species;
SELECT * FROM v2;
-- set opertations:
--iffy example
SELECT Book_page, Nest_ID, Egg_num, Length, Width FROM Bird_eggs;
SELECT Book_page, NEST_ID, Egg_num, Length*25.4, Width*25.4 FROM Bird_eggs
    WHERE Book_page = 'b14.6'
    UNION
-- ####################################################################
-- # Basic SELECT statement
-- # See https://www.ibm.com/docs/en/db2-for-zos/13?topic=statements-select for complete syntax.
-- ####################################################################
SELECT Book_page, Nest_ID, Egg_num, Length, Width, FROM Bird_eggs
    WHERE Book_page != 'b14.6';
--UNION vs UNION ALL
-- just mashes tables together; not intelligent
-- third way to answer: which species have no nest data?
SELECT Code FROM Species
    Except SELECT DISTINCT Species FROM Bird_nests;
DROP VIEW v;

-- (*) means get all columns
-- COUNT means get all rows