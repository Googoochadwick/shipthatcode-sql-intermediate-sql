CREATE TABLE customers (id INTEGER, name TEXT, email TEXT);
INSERT INTO customers VALUES
    (1, 'Ada', 'ada@x.io'),
    (2, 'Bob', 'bob@x.io'),
    (3, 'Carol', 'carol@x.io');

-- TODO: two statements.
-- 1. Create an index named idx_customers_email on the email column of
--    customers.
-- 2. Then write the lookup itself: select the name of the customer whose
--    email is 'ada@x.io'. Only that name should be printed.
--
-- The output cannot show you whether the index was used -- that is what
-- EXPLAIN QUERY PLAN is for. Run it yourself if you want to see the plan,
-- but do not leave it in your final answer; it prints extra rows.
create index idx_customers_email on customers(email);
select name from customers where id = 'ada@x.io';