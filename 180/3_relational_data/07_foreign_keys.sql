/* 2) Update the orders table so that referential integrity will be preserved for the data between orders and products. */
ALTER TABLE orders
ADD CONSTRAINT order_product_id_fkey FOREIGN KEY (product_id) REFERENCES products(id);

/* 3) */
INSERT INTO products(name) VALUES
  ('small bolt'),
  ('large bolt');

INSERT INTO orders(product_id, quantity) VALUES
  (1, 10),
  (1, 25),
  (2, 15);

/*
  4) Write a SQL statement that returns a result like this:

   quantity |    name
  ----------+------------
         10 | small bolt
         25 | small bolt
         15 | large bolt
  (3 rows)
*/

SELECT orders.quantity, products.name /* `SELECT quantity, name` also works since there is no name conflict */
FROM orders
INNER JOIN products ON (products.id = orders.product_id);

/*
  6) Write a SQL statement that will prevent NULL values from being stored in orders.product_id. What happens if you execute that statement?
*/
-- ERROR:  column "product_id" contains null values
ALTER TABLE orders
ALTER COLUMN product_id SET NOT NULL;

/* 7) Make any changes needed to avoid the error message encountered in #5. */
UPDATE orders SET product_id = 1
WHERE product_id IS NULL;

/*
  8) Create a new table called reviews to store the data shown below. This table should include a primary key and a reference to the products table.
*/

CREATE TABLE reviews (
  id serial PRIMARY KEY,
  product_id integer REFERENCES products (id),
  content text
);

/*
  9. Write SQL statements to insert the data shown in the table in #7.
*/
INSERT INTO reviews(product_id, content) VALUES
  (1, 'a little small'),
  (1, 'very round!'),
  (2, 'could have been smaller');
