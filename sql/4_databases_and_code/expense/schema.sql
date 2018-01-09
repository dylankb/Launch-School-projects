CREATE TABLE expenses (
  id serial PRIMARY KEY,
  amount numeric(6,2) NOT NULL,
  memo text NOT NULL,
  created_on date NOT NULL DEFAULT NOW()
);

/* Works */
INSERT INTO expenses(amount, memo) VALUES
  (9999.99, 'Sell company');

/* Fails */
-- INSERT INTO expenses(amount, memo) VALUES
--   (10000, 'Sell another company');

/* Works */
INSERT INTO expenses(amount, memo) VALUES
  (.01, 'Find change');

INSERT INTO expenses (amount, memo) VALUES (14.56, 'Pencils');
INSERT INTO expenses (amount, memo) VALUES (3.29, 'Coffee');
INSERT INTO expenses (amount, memo) VALUES (49.99, 'Text Editor');

/* Works */
-- INSERT INTO expenses(amount, memo) VALUES
--   (.001, 'Split penny');
--
-- /* Works */
-- INSERT INTO expenses(amount, memo) VALUES
--   (.000000001, 'Tiny interest');
--
-- /* Fails */
-- INSERT INTO expenses(amount, memo) VALUES
--   (-100000, 'Purchase company');

/* Add a check constraint to the expenses table to ensure that amount only holds a positive value. */
-- DELETE FROM expenses WHERE memo = 'Purchase company' OR memo = 'Tiny interest' OR memo = 'Split penny';

ALTER TABLE expenses ADD CONSTRAINT positive_amount_check CHECK (amount >= .01);
