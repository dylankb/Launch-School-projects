/*
  Extracting 1M relationship from exitisting data
*/

/* Original query to get films */
SELECT * FROM films LIMIT 1;

title     | year | genre |   director    | duration
----------+------+-----------+-----------+---------
 Die Hard | 1988 | action | John McTiernan |  132

/* Create new table */
CREATE TABLE directors (id serial PRIMARY KEY, name text NOT NULL);
/* Insert data */
INSERT INTO directors (name) VALUES
 ('John McTiernan'),
 ('Michael Curtiz'),
 ('Francis Ford Coppola'),
 ('Michael Anderson'),
 ('Tomas Alfredson'),
 ('Mike Nichols');

/* Add foreign key to original table */
UPDATE films SET director_id=1 WHERE director = 'John McTiernan';
UPDATE films SET director_id=2 WHERE director = 'Michael Curtiz';
UPDATE films SET director_id=3 WHERE director = 'Francis Ford Coppola';
UPDATE films SET director_id=4 WHERE director = 'Michael Anderson';
UPDATE films SET director_id=5 WHERE director = 'Tomas Alfredson';
UPDATE films SET director_id=6 WHERE director = 'Mike Nichols';

/* Cleanup extra data from original table */
ALTER TABLE films DROP COLUMN director;

/* Add back constraints */
ALTER TABLE films ALTER COLUMN director_id SET NOT NULL;

ALTER TABLE directors ADD CONSTRAINT valid_name
 CHECK (length(name) >= 1 AND "position"(name, ' ') > 0);

/* New query to get films */
SELECT films.title, films.year, directors.name AS director, films.duration
FROM films INNER JOIN directors ON directors.id = films.director_id;

title     | year | genre |   director    | duration
----------+------+-----------+-----------+---------
 Die Hard | 1988 | action | John McTiernan |  132
