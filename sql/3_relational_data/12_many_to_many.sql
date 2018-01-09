/* Write a SQL statement that will return the following result */
SELECT books.id, books.author, string_agg(categories.name, ', ') AS categories
FROM books_categories
  INNER JOIN books ON (books.id = books_categories.book_id)
  INNER JOIN categories ON (categories.id = books_categories.category_id)
GROUP BY books.id;

/* Add additional data to the db */
INSERT INTO categories(name) VALUES
  ('Space Exploration'),
  ('Cookbook'),
  ('South Asia');

ALTER TABLE books
ALTER COLUMN name TYPE text;

INSERT INTO books(author, title) VALUES
  ('Lynn Sherr', 'Sally Ride: America''s First Woman in Space'),
  ('Charlotte Brontë', 'Jane Eyre'),
  ('Meeru Dhalwala and Vikram Vij', 'Vij''s: Elegant and Inspired Indian Cuisine');

INSERT INTO books_categories(book_id, category_id) VALUES
  ((SELECT id FROM books WHERE title = 'Sally Ride: America''s First Woman in Space'), (SELECT id FROM categories WHERE name = 'Biography')),
  ((SELECT id FROM books WHERE title = 'Sally Ride: America''s First Woman in Space'), (SELECT id FROM categories WHERE name = 'Nonfiction')),
  ((SELECT id FROM books WHERE title = 'Sally Ride: America''s First Woman in Space'), (SELECT id FROM categories WHERE name = 'Space Exploration'));

  ((SELECT id FROM books WHERE title = 'Jane Eyre'), (SELECT id FROM categories WHERE name = 'Fiction')),
  ((SELECT id FROM books WHERE title = 'Jane Eyre'), (SELECT id FROM categories WHERE name = 'Classics')),

  ((SELECT id FROM books WHERE title = 'Vij''s: Elegant and Inspired Indian Cuisine'), (SELECT id FROM categories WHERE name = 'Cookbook')),
  ((SELECT id FROM books WHERE title = 'Vij''s: Elegant and Inspired Indian Cuisine'), (SELECT id FROM categories WHERE name = 'Nonfiction')),
  ((SELECT id FROM books WHERE title = 'Vij''s: Elegant and Inspired Indian Cuisine'), (SELECT id FROM categories WHERE name = 'South Asia'));

/* Write a statement to return name, book_count, book_titles */
SELECT categories.name, COUNT(books.id) AS book_count, string_agg(books.title,', ') AS book_titles
FROM books_categories
  INNER JOIN books ON (books.id = books_categories.book_id)
  INNER JOIN categories ON (categories.id = books_categories.category_id)
GROUP BY categories.name;

/*
  Write a SQL statement to add a uniqueness constraint on the combination of columns book_id and category_id of the books_categories table. This constraint should be a table constraint; so, it should check for uniqueness on the combination of book_id and category_id across all rows of the books_categories table.
*/
ALTER TABLE books_categories
ADD CONSTRAINT unique_book_category UNIQUE(book_id, category_id); /* ADD UNIQUE ... also works */
