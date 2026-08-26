CREATE TABLE products (category TEXT, price INTEGER);
INSERT INTO products VALUES
    ('food', 10),
    ('tech', 500),
    ('food', 25),
    ('tech', 1500),
    ('book', 30),
    ('book', 20);

-- TODO: define a CTE that totals price per category, then have the main
-- query keep only the categories whose total is over 100 and print them as
-- <category>|<total>, sorted alphabetically by category.
--
--   WITH <name> AS ( <the SELECT that aggregates> )
--   <the SELECT that filters and orders>
with total as(
    select category, SUM(price) as total 
    from products 
    group by category
)


SELECT category || '|' || total FROM total where total > 100;   -- replace: not grouped, not filtered
