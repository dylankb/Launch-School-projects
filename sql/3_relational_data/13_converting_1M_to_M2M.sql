/* Write a SQL statement that will add a primary key column to films. */
ALTER TABLE films
ADD COLUMN id serial PRIMARY KEY;

/*
  Write the SQL statement needed to create a join table that will allow a film to have multiple directors, and directors to have multiple films. Include an id column in this table, and add foreign key constraints to the other columns.
*/
CREATE TABLE directors_films(
  id serial PRIMARY KEY,
  director_id integer REFERENCES directors,
  film_id integer REFERENCES films
);

INSERT INTO directors_films(director_id, film_id) VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4),
  (5, 5),
  (6, 6),
  (3, 7),
  (7, 8),
  (8, 9),
  (4, 10);

/* Write a SQL statement to remove any unneeded columns from films. */
ALTER TABLE films
DROP COLUMN director_id;

/* Return title of film and name of director */
SELECT films.title, directors.name
FROM directors_films
  INNER JOIN films ON (films.id = directors_films.film_id)
  INNER JOIN directors ON (directors.id = directors_films.director_id)
ORDER BY films.title;

INSERT INTO films(title, year, genre, duration) VALUES
  ('Fargo', 1996, 'comedy', 98),
  ('No Country for Old Men', 2007, 'western', 122),
  ('Sin City', 2005, 'crime', 124),
  ('Spy Kids', 2001, 'scifi', 88);

INSERT INTO directors(name) VALUES
  ('Joel Cohen'),
  ('Ethan Cohen'),
  ('Frank Miller'),
  ('Robert Rodriguez');

INSERT INTO directors_films(director_id, film_id) VALUES
  ((SELECT id FROM directors WHERE directors.name = 'Joel Cohen'), (SELECT id FROM films WHERE films.title = 'Fargo' )),
  ((SELECT id FROM directors WHERE directors.name = 'Joel Cohen'), (SELECT id FROM films WHERE films.title = 'No Country for Old Men' )),
  ((SELECT id FROM directors WHERE directors.name = 'Ethan Cohen'), (SELECT id FROM films WHERE films.title = 'No Country for Old Men' )),
  ((SELECT id FROM directors WHERE directors.name = 'Frank Miller'), (SELECT id FROM films WHERE films.title = 'Sin City' )),
  ((SELECT id FROM directors WHERE directors.name = 'Robert Rodriguez'), (SELECT id FROM films WHERE films.title = 'Sin City' )),
  ((SELECT id FROM directors WHERE directors.name = 'Robert Rodriguez'), (SELECT id FROM films WHERE films.title = 'Spy Kids' ));

/*
  Write a SQL statement that determines how many films each director in the database has directed. Sort the results by number of films (greatest first) and then name (in alphabetical order)
*/
SELECT directors.name, COUNT(films.id) as directed_count
FROM directors_films
  INNER JOIN directors ON (directors.id = directors_films.director_id)
  INNER JOIN films ON (films.id = directors_films.film_id)
GROUP BY directors.name
ORDER BY directed_count DESC;
