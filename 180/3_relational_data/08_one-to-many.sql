/* 1. Insert column with reserved name */
INSERT INTO calls (contact_id, "when", duration) VALUES  (6, '2016-01-18 14:47:00', 632);

/* 2. All calls not made to William Smith */
SELECT calls.*
FROM calls INNER JOIN contacts ON (calls.contact_id = contacts.id)
WHERE contacts.first_name != 'William' AND contacts.last_name != 'Smith';

/* 3. Add additional data */
INSERT INTO contacts (first_name, last_name, number) VALUES ('Merve', 'Elk', 6343511126);
INSERT INTO calls (contact_id, "when", duration) VALUES  (27, '2016-01-17 11:52:00', 175);

INSERT INTO contacts (first_name, last_name, number) VALUES ('Sawa', 'Fyodorov', 6125594874);
INSERT INTO calls (contact_id, "when", duration) VALUES  (28, '2016-01-18 21:22:00', 79);

/* 4. Prevent duplicate numbers */
-- ALTER TABLE contacts ALTER COLUMN number SET UNIQUE();
-- ALTER TABLE contacts ADD CONSTRAINT no_dup_number CHECK UNIQUE(number);

ALTER TABLE contacts ADD CONSTRAINT number_unique UNIQUE (number);
