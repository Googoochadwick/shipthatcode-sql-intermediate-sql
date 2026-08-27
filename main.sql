CREATE TABLE accounts (id INTEGER PRIMARY KEY, balance INTEGER);
INSERT INTO accounts VALUES (1, 500), (2, 600);

-- TODO: inside a BEGIN ... COMMIT block, move 100 from account 1 to
-- account 2 -- subtract from 1, add to 2. Keep the SELECT below as the
-- last statement so the final balances are printed.
begin;
update accounts set balance = balance - 100 where id is 1;
update accounts set balance = balance + 100 where id is 2;
commit;

SELECT id || '|' || balance FROM accounts ORDER BY id;
