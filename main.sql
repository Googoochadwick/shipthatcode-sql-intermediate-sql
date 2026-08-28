CREATE TABLE events (id INTEGER, type TEXT);
INSERT INTO events VALUES
    (1, 'login'),
    (2, 'purchase'),
    (3, 'login'),
    (4, 'login'),
    (5, 'purchase');

-- TODO: one row, three counts, printed as <total>|<logins>|<purchases>.
--
-- A conditional aggregate is a normal aggregate over an expression that
-- yields something to count for the rows you want and nothing for the rest.
-- Note: this grader runs SQLite 3.27, which has no FILTER clause -- use the
-- portable CASE WHEN form.

SELECT 
COUNT(*),
SUM(CASE WHEN <type = "login"> THEN 1 ELSE 0 END), 
SUM(CASE WHEN <type = "purchases"> THEN 1 ELSE 0 END), 
FROM events;   -- replace: this is only the first of the three numbers
