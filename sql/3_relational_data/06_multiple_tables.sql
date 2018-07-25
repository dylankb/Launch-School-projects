/* Load this DB https://raw.githubusercontent.com/launchschool/sql_course_data/master/sql-and-relational-databases/relational-data-and-joins/working-with-multiple-tables/theater_full.sql */

/* 2) Write a query that determines how many tickets have been sold.. */
SELECT COUNT(id) FROM tickets;

/* 3) Write a query that determines how many different customers purchased tickets to at least one event. */

SELECT COUNT(DISTINCT(customer_id)) FROM tickets;

/* Same version but with a join - the one above is more efficient */

SELECT COUNT(DISTINCT(customers.id))
FROM customers
INNER JOIN tickets ON (customers.id = tickets.customer_id);

/* However with this approach you could run additional types queries on on the data, such as those relating to tickets. Such as, what events did each of these customers attend? */

SELECT DISTINCT(customers.id), string_agg(tickets.event_id::text, ',')
FROM customers
INNER JOIN tickets ON (customers.id = tickets.customer_id)
GROUP BY customers.id

/* 4) Write a query that determines what percentage of the customers in the database have purchased a ticket to one of the events. */

/* Test */
SELECT COUNT(DISTINCT(customer_id)) AS purchasers, (
  SELECT COUNT(id) AS total_customers
    FROM customers
)

/* Subquery:
   Happens to work because each customer_id matches id from the customers table
*/
SELECT COUNT(DISTINCT(customer_id)) / (
  SELECT COUNT(id) AS total_customers
    FROM customers
)::float * 100

FROM tickets;

/* Join */
SELECT COUNT(DISTINCT tickets.customer_id) /
       COUNT(DISTINCT customers.id)::float * 100 AS percent /* Use DISTINCT w/ JOINs (else larger than table total - see below) */
  FROM customers                                            /* Return all customers */
  LEFT JOIN tickets ON tickets.customer_id = customers.id;  /* Return tickets with a customer id matching an id from customer table */
                                                            /* (Actually includes all tickets - each has a (matching) customer id) */

/*
   Comparable query on "checkouts" data
   Percentage of users who checked out books
*/
SELECT COUNT(DISTINCT users.id), COUNT(DISTINCT users_books.user_id)
  FROM users
LEFT JOIN users_books ON (users_books.user_id = users.id);

SELECT users.id, users.username, users_books.user_id
  FROM users
  INNER JOIN users_books ON users_books.user_id = users.id;
/*
  JOIN makes a separate row for each pair (join) in the join clause
  Note that John Smith is listed twice
*/

|id |  username   | user_id|
|----|------------|--------|
| 1 | John Smith  |       1|
| 1 | John Smith  |       1| /* Extra user listing */
| 2 | Jane Smiley |       2|

SELECT users.id, users.username, users_books.user_id
  FROM users
  LEFT OUTER JOIN users_books ON users_books.user_id = users.id;
/*
  A LEFT JOIN will additionally include rows for unmatched LEFT table rows, so if your FROM table is users, you might return more users than are in your users table. See below
*/

| id |  username   | user_id|
|----|-------------|---------|
|  1 | John Smith  |        1|
|  1 | John Smith  |        1| /* Extra user listing */
|  2 | Jane Smiley |        2|
|  3 | Alice Munro | |


/*5) Write a query that returns the name of each event and how many tickets were sold for it, in order from most popular to least popular.*/

    SELECT events.name, COUNT(tickets.id)
      FROM events
           INNER JOIN tickets ON (tickets.event_id = events.id) /* Left join better */
     GROUP BY events.id
     ORDER BY count DESC;

/* This works, but if it we there had been any events WITHOUT any ticket sales, they wouldn't have shown

/*)
   Test - Sample data on "checkouts" data
*/

/*) Users and checkouts.
    All checkouts have a user_id that matches a user.id, so they're all included
*/
    SELECT users.id, users.username, users_books.user_id
      FROM users
LEFT JOIN users_books ON (users_books.user_id = users.id);

id |  username   | user_id
----+-------------+---------
 1 | John Smith  |       1
 1 | John Smith  |       1
 2 | Jane Smiley |       2
 3 | Alice Munro |

/* Users who checked out books */
    SELECT users.id, users.username, users_books.user_id
      FROM users
INNER JOIN users_books ON (users_books.user_id = users.id)

id |  username   | user_id
----+-------------+---------
 1 | John Smith  |       1
 1 | John Smith  |       1
 2 | Jane Smiley |       2

 /* Checkouts per users who checked books out */
    SELECT users.id, users.username, COUNT(users_books.user_id) /* Counts checking out a book multiple times */
      FROM users
INNER JOIN users_books ON (users_books.user_id = users.id)
  GROUP BY users.username, users.id;

 id |  username   | count
 ----+-------------+-------
  2 | Jane Smiley |     1
  1 | John Smith  |     2

/*
  6) Write a query that returns the user id, email address, and number of events for all customers that have purchased tickets to three events.
*/
SELECT customers.id, customers.email, COUNT(DISTINCT tickets.event_id) /* Prevent counting customers attending same event multiple times */
  FROM customers INNER JOIN tickets ON (tickets.customer_id = customers.id)
  GROUP BY customers.id
  HAVING COUNT(DISTINCT tickets.event_id) = 3;

/*
  This also works, it just returns the events as well and provides a count of those ids.
  If you wanted to access details about the events, then this would be the query to use.
*/
    SELECT customers.id, customers.email, COUNT(DISTINCT events.id)
      FROM customers
INNER JOIN tickets ON (tickets.customer_id = customers.id)
INNER JOIN events ON (events.id = tickets.event_id)
  GROUP BY customers.id
    HAVING COUNT(DISTINCT events.id) = 3;

/*
  7) Write a query to print out a report of all tickets purchased by the customer with the email address 'gennaro.rath@mcdermott.co'. The report should include the event name and starts_at and the seat's section name, row, and seat number.
*/

SELECT events.name, events.starts_at, sections.name
  FROM events
    INNER JOIN tickets ON (tickets.event_id = events.id)
    INNER JOIN customers ON (tickets.customer_id = customers.id)
    INNER JOIN seats ON (tickets.seat_id = seats.id)
    INNER JOIN sections ON (sections.id = seats.section_id)
 WHERE customers.email = 'gennaro.rath@mcdermott.co';

/* Same query, but maybe a bit clearer to say FROM tickets as tickets is reused mutiple times */
SELECT events.name AS event, events.starts_at, sections.name AS section, seats.row, seats.number AS seat
 FROM tickets
   INNER JOIN events ON tickets.event_id = events.id
   INNER JOIN customers ON tickets.customer_id = customers.id
   INNER JOIN seats ON tickets.seat_id = seats.id
   INNER JOIN sections ON seats.section_id = sections.id
WHERE customers.email = 'gennaro.rath@mcdermott.co';
