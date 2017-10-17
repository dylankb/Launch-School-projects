CREATE DATABASE billing;
\c billing

CREATE TABLE customers (
  id serial PRIMARY KEY,
  name text NOT NULL,
  payment_token char(8) UNIQUE CHECK (payment_token ~ '[A-Z]{8}')
);

CREATE TABLE services (
  id serial PRIMARY KEY,
  description text NOT NULL,
  price numeric(10, 2) NOT NULL CHECK (price >= 0.00)
);

INSERT INTO customers(name, payment_token) VALUES
  ('Pat Johnson', 'XHGOAHEQ'),
  ('Nancy Monreal', 'JKWQPJKL'),
  ('Lynn Blake', 'KLZXWEEE'),
  ('Chen Ke', 'KWETYCVX'),
  ('Scott Lakso', 'UUEAPQPS'),
  ('Jim Pornot', 'XKJEYAZA');

INSERT INTO services(description, price) VALUES
  ('Unix Hosting', 5.95),
  ('DNS', 4.95),
  ('Whois Registration', 1.95),
  ('High Bandwidth', 15.00),
  ('Business Support', 250.00),
  ('Dedicated Hosting', 50.00),
  ('Bulk Email', 250.00),
  ('One-to-one Training', 999.00);

CREATE TABLE customers_services (
  id serial PRIMARY KEY,
  customer_id integer REFERENCES customers ON DELETE CASCADE,
  service_id integer REFERENCES services,
  UNIQUE(customer_id, service_id)
);

INSERT INTO customers_services(customer_id, service_id) VALUES
  ((SELECT id FROM customers WHERE name = 'Pat Johnson'), (SELECT id FROM services WHERE description = 'Unix Hosting')),
  ((SELECT id FROM customers WHERE name = 'Pat Johnson'), (SELECT id FROM services WHERE description = 'Whois Registration')),
  ((SELECT id FROM customers WHERE name = 'Pat Johnson'), (SELECT id FROM services WHERE description = 'DNS')),

  ((SELECT id FROM customers WHERE name = 'Lynn Blake'), (SELECT id FROM services WHERE description = 'Unix Hosting')),
  ((SELECT id FROM customers WHERE name = 'Lynn Blake'), (SELECT id FROM services WHERE description = 'DNS')),
  ((SELECT id FROM customers WHERE name = 'Lynn Blake'), (SELECT id FROM services WHERE description = 'Whois Registration')),
  ((SELECT id FROM customers WHERE name = 'Lynn Blake'), (SELECT id FROM services WHERE description = 'High Bandwidth')),
  ((SELECT id FROM customers WHERE name = 'Lynn Blake'), (SELECT id FROM services WHERE description = 'Business Support')),

  ((SELECT id FROM customers WHERE name = 'Chen Ke'), (SELECT id FROM services WHERE description = 'Unix Hosting')),
  ((SELECT id FROM customers WHERE name = 'Chen Ke'), (SELECT id FROM services WHERE description = 'High Bandwidth')),

  ((SELECT id FROM customers WHERE name = 'Scott Lakso'), (SELECT id FROM services WHERE description = 'Unix Hosting')),
  ((SELECT id FROM customers WHERE name = 'Scott Lakso'), (SELECT id FROM services WHERE description = 'DNS')),
  ((SELECT id FROM customers WHERE name = 'Scott Lakso'), (SELECT id FROM services WHERE description = 'Dedicated Hosting')),

  ((SELECT id FROM customers WHERE name = 'Jim Pornot'), (SELECT id FROM services WHERE description = 'Unix Hosting')),
  ((SELECT id FROM customers WHERE name = 'Jim Pornot'), (SELECT id FROM services WHERE description = 'Dedicated Hosting')),
  ((SELECT id FROM customers WHERE name = 'Jim Pornot'), (SELECT id FROM services WHERE description = 'Bulk Email'));

/* Write a query to retrieve the customer data for every customer who currently subscribes to at least one service. */
SELECT customers.*
FROM customers_services
  INNER JOIN customers ON (customers.id = customers_services.customer_id)
  -- INNER JOIN services ON (services.id = customers_services.service_id); /* Unnecessary */

/* Check services for a specific customer */
SELECT customers.*, services.*
  FROM customers_services
    INNER JOIN customers ON (customers.id = customers_services.customer_id)
    INNER JOIN services ON (services.id = customers_services.service_id)
WHERE customers.id = (SELECT id FROM customers WHERE name = 'Pat Johnson');

/* Write a query to retrieve the customer data for every customer who does not currently subscribe to any services. */
SELECT customers.*
FROM customers
  LEFT JOIN customers_services ON (customers.id = customers_services.customer_id)
WHERE customers_services.service_id IS NULL;

/* Can you write a query that displays all customers with no services and all services that currently don't have any customers?  */
SELECT customers.*, services.*
FROM customers
  FULL JOIN customers_services ON (customers.id = customers_services.customer_id)
  FULL JOIN services ON (services.id = customers_services.service_id)
WHERE customers_services.service_id IS NULL OR service_id IS NULL;

/* Write a query to retrieve the customer data for every customer who does not currently subscribe to any services. */
SELECT services.*, customers_services.*
FROM customers_services
  RIGHT JOIN services ON (services.id = customers_services.service_id)
WHERE customers_services.customer_id IS NULL;

/* Write a query to display a list of all customer names together with a comma-separated list of the services they use. */
SELECT customers.name, string_agg(services.description, ', ') AS services
FROM customers
  LEFT JOIN customers_services ON (customers.id = customers_services.customer_id)
  LEFT JOIN services ON (services.id = customers_services.service_id)
GROUP BY customers.name;

/*
  Two columns, with matching services row separated (i.e. if multiple services then user column will be blanks)
  Chen Ke-Hua    | High Bandwidth
                 | Unix Hosting
*/
SELECT
  CASE
    WHEN customers.name = lag(customers.name) OVER (ORDER BY customers.name) THEN NULL
    ELSE customers.name
  END,
  services.description
FROM customers
  LEFT JOIN customers_services ON customer_id = customers.id
  LEFT JOIN services ON services.id = service_id;
/*
  Write a query that displays the description for every service that is subscribed to by at least 3 customers. Include the customer count for each description in the report.
*/
SELECT services.description, COUNT(customers_services.customer_id) as customer_count
FROM customers_services
  INNER JOIN services ON (services.id = customers_services.service_id)
GROUP BY services.description
HAVING COUNT(customers_services.customer_id) >= 3;

/* Write query for total gross of services */
SELECT SUM(services.price)
FROM customers_services
  INNER JOIN services ON (services.id = customers_services.service_id);

/*
  A new customer, 'John Doe', has signed up with our company. His payment token is `EYODHLCN'. Initially, he has signed up for UNIX hosting, DNS, and Whois Registration. Create any SQL statement(s) needed to add this record to the database.
*/
INSERT INTO customers(name, payment_token) VALUES
  ('John Doe', 'EYODHLCN');

INSERT INTO customers_services(customer_id, service_id) VALUES
  ((SELECT id FROM customers WHERE name = 'John Doe'), (SELECT id FROM services WHERE description = 'Unix Hosting')),
  ((SELECT id FROM customers WHERE name = 'John Doe'), (SELECT id FROM services WHERE description = 'DNS')),
  ((SELECT id FROM customers WHERE name = 'John Doe'), (SELECT id FROM services WHERE description = 'Whois Registration'));

/*
  Query for the amount of expected income from "big ticket" services (those services that cost more than $100) and the maximum income the company could achieve if it managed to convince all of its customers to select all of the company's big ticket items.
*/
SELECT SUM(services.price)
FROM customers_services
  INNER JOIN services ON (services.id = customers_services.service_id)
WHERE services.price > 100;

SELECT SUM(services.price)
FROM services, customers
WHERE services.price > 100;

/* Deleting Bulk Email service and Chen Ke*/
DELETE FROM customers_services
WHERE service_id = (SELECT id FROM services WHERE description = 'Bulk Email');

DELETE FROM services
WHERE services.description = 'Bulk Email';

DELETE FROM customers
WHERE customers.name = 'Chen Ke';
