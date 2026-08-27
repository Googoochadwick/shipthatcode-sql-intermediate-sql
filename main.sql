CREATE TABLE emps (name TEXT, department TEXT, salary INTEGER);
INSERT INTO emps VALUES
    ('Alice', 'eng', 100000),
    ('Bob', 'eng', 80000),
    ('Carol', 'eng', 120000),
    ('Dan', 'eng', 90000),
    ('Eve', 'sales', 70000),
    ('Frank', 'sales', 60000),
    ('Grace', 'sales', 80000);

-- TODO: rank employees within their own department by salary (highest = 1),
-- keep the top 3 of each department, and print <name>|<department>|<salary>
-- ordered by department, then salary descending.
--
-- Remember: a window function cannot appear in WHERE. Compute the rank in a
-- CTE, give it an alias, and filter on that alias in the outer query.

with rng as (
    select
    name,
    department,
    salary,
    ROW_NUMBER() OVER (PARTITION BY Department ORDER BY salary) as rank
    from emps
)

SELECT name || '|' || department || '|' || salary FROM rng
where rank <= 3
order by department asc, salary desc;

