CREATE TABLE customers (id INTEGER, name TEXT);
INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Carol'), (4, 'Dan');

CREATE TABLE orders (customer_id INTEGER, item TEXT);
INSERT INTO orders VALUES (1, 'book'), (3, 'phone'), (1, 'pen');

-- TODO: print the names of customers who have never placed an order,
-- sorted alphabetically, using a set operator (not NOT IN, not a LEFT JOIN).
--
-- Both SELECTs must produce the same single column, and the one ORDER BY
-- goes at the very end -- it sorts the combined result.
with ids as(
SELECT id FROM customers
except
select customer_id from orders)   -- replace: this keeps everyone

select name from customers where id in (select id from ids);