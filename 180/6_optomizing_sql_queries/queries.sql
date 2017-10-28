/* Write a SQL query that shows all items that have had bids put on them. Use the logical operator IN for this exercise, as well as a subquery. */
SELECT name AS "Bid on Items"
FROM items
WHERE id IN (SELECT item_id
  FROM bids
  GROUP BY item_id);

/* Write a SQL query that shows all items that have not had bids put on them. Use the logical operator NOT IN for this exercise, as well as a subquery. */
SELECT name AS "Not Bid On"
FROM items
WHERE id NOT IN (SELECT DISTINCT item_id FROM bids);

/* Write a SELECT query that returns a list of names of everyone who has bid in the auction. While it is possible (and perhaps easier) to do this with a JOIN clause, we're going to do things differently: use a subquery with the EXISTS clause instead. */
SELECT name
FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bidders.id = bids.bidder_id);

/* Equivalent join */
SELECT bidders.name
FROM bidders
  INNER JOIN bids ON (bids.bidder_id = bidders.id)
GROUP by bidders.name;

/* Write an SQL query that returns the names of all items that have bids of less than 100 dollars. To accomplish this, use an ANY clause, along with a subquery.

Video Game
Outdoor Grill
Vase

*/

-- SELECT item_id, array_agg(amount) as bids
-- FROM bids
-- WHERE item_id = 1
-- GROUP BY item_id
-- ORDER BY item_id;


/* I was confused by this for an embarrassingly long amount of time, partly due to the confusing nature of the question's wording and data, so I tried to break it down in a more visual way in case that helps others. Here's the solution's WHERE 100.00 > ANY (SELECT amount FROM bids WHERE items.id = bids.item_id); converted to an INNER JOIN to view the data it returns. */

SELECT name as "Bids Less Than 100 Dollars"
FROM items
WHERE 100.00 > ANY
  (SELECT amount FROM bids WHERE items.id = bids.item_id);

/* JOIN equivalent to the WHERE ... ANY subquery */
SELECT items.id, items.name, bids.amount
  FROM items
    INNER JOIN bids ON (items.id = bids.item_id)
  WHERE 100.00 > amount;

  1 | Video Game    |  40.00
  1 | Video Game    |  52.00
  1 | Video Game    |  53.00
  1 | Video Game    |  70.87
  2 | Outdoor Grill |  83.25
  5 | Vase          |  21.72
  5 | Vase          |  23.00
  5 | Vase          |  25.00
  5 | Vase          |  30.00
  5 | Vase          |  32.00
  5 | Vase          |  33.00
  5 | Vase          |  38.00
  5 | Vase          |  40.00
  5 | Vase          |  42.00

/* So the original ANY query is selecting names of items where there are bid amounts that are under 100. Or trying to mirror the query's language, where 100 is greater than any given rows bid amount. Breaking that down a bit further, this is probably similar to how the ANY evaluation works with the Video Game bids as an example:

SELECT 100 > ANY('{40.00,52.00,53.00,70.87}'::numeric[]);

For a while I was confused why we aren't getting 4 entries for Video Game in our results. The reason for that is because this subquery is getting names from the items table and doing a WHERE filter on them, and not finding the intersection or rows like you'd get from running a join. Anyways, in the ALL query it's checking that 100 is greater than all row bid amounts.

SELECT 100 > ALL('{40.00,52.00,53.00,70.87}'::numeric[]);

To actually find "Highest Bid Less Than 100 Dollars" you'd have to use the ALL syntax. To confirm that this is the case, we can add an additional bid of less than 100 to the Tent item (id 4) from user 1. I added this as a new row to my bids.csv - 27,1, 4, 99.00. Now if we run it we get we get some different results.

SELECT name as "Highest Bid Less Than 100 Dollars"
FROM items
WHERE 100.00 > ANY
  (SELECT amount FROM bids WHERE items.id = bids.item_id);

Video Game
Outdoor Grill
Tent
Vase

We're now returning Tent as well, even though it has bids above 100. This is fine, but I wouldn't say it falls into the category of "Highest Bid Less Than 100 Dollars". Finally, if you run the the ALL syntax it will return the expected three item names.
*/

SELECT name as "Highest Bid Less Than 100 Dollars"
FROM items
WHERE 100.00 > ALL
  (SELECT amount from bids WHERE items.id = bids.item_id) AND items.sales_price IS NOT NULL;

SELECT name, amount as "All Bids"
FROM items
  INNER JOIN bids ON (items.id = bids.item_id);

SELECT name, max(amount) as "Max Bids"
FROM items
  INNER JOIN bids ON (items.id = bids.item_id)
GROUP BY name;

/* Write an SQL query that finds the largest number of bids from an individual bidder. */
SELECT MAX(counts) FROM
  (SELECT bidder_id, COUNT(bidder_id) AS counts FROM bids GROUP BY bidder_id) AS bid_counts;

SELECT MAX(bid_counts.count) FROM
  (SELECT bidder_id, COUNT(bidder_id) FROM bids GROUP BY bidder_id) AS bid_counts;

/*
  This query generates a table that has the total bids for each bidder. Take note of the column name, count, as that is information we'll need to use in our outer query.

  We now want to find the maximum value out of all the bid counts. We can use the aggregate function MAX to do this in our outer query. We also must add an alias for the subquery table, which lets us use bid_counts.count as a column name: bid_counts is an alias for the generated table, and count is the column name we want. Putting it all together, we can write a query to search the generated table and locate the entry that has the greatest number of bids.

  This ones shorter (but less efficient)
*/
SELECT COUNT(bidder_id) AS max_bid FROM bids
  GROUP BY bidder_id
  ORDER BY max_bid DESC
  LIMIT 1;

/* For this exercise, use a scalar subquery to determine the number of bids on each item. The entire query should return a table that has the name of each item along with the number of bids on an item. */
SELECT items.name, (SELECT COUNT(item_id) FROM bids WHERE bids.item_id = items.id)
FROM items;

/* Can you come up with the equivalent query that uses a JOIN clause? */
SELECT items.name, COUNT(item_id)
  FROM items
    LEFT OUTER JOIN bids ON (bids.item_id = items.id)
  GROUP BY items.name;
/* Don't count item_id because it all items are listed, so it could never be a zero */

/* Write an SQL query that will display the id for the item that matches all of the data that we know, but does not use the AND keyword. Here is the data we know: */
SELECT id FROM items
  WHERE ROW('Painting', 100.00, 250.00) =
  ROW(name, initial_price, sales_price);

/* We use ROW to construct two virtual rows: one that contains the data we want, and one that represents the data for each row in the table. We then compare these two virtual rows to find the row that matches our data and extract its id. */
