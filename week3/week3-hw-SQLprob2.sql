--Week 3 - SQL problem 2

-- PART 1
-- the query is not correct because it does not specify how to group the data when using the aggregate 'MAX' function. If a query includes an aggregate function or a GROUP BY, SQL wants to collapse the whole table down to a single row, or each group down to a single row.

-- PART 2
SELECT Site_name, Area FROM Site ORDER BY Area DESC LIMIT 1;

-- PART 3
SELECT Site_name, Area FROM Site WHERE Area = (SELECT MAX(Area) FROM Site);