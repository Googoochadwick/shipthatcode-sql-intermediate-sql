CREATE TABLE employees (name TEXT, salary INTEGER);
INSERT INTO employees VALUES
    ('Alice', 80000),
    ('Bob', 50000),
    ('Carol', 95000),
    ('Dan', 60000),
    ('Eve', 70000);

-- TODO: print the name of every employee paid MORE than the company-wide
-- average salary (strictly greater), one name per line, in INSERT order.
-- The average itself is not something WHERE can compute for you; it has to
-- be worked out by a query of its own before the comparison can happen.

SELECT name FROM employees;   -- replace: this prints all five
