```sql
SELECT * FROM users;
```

| id |  username   | enabled |         last_login         |
|----|-------------|---------|----------------------------|
 1 | John Smith  | t       | 2016-04-03 11:53:18.730872
 2 | Jane Smiley | t       | 2016-04-03 11:53:18.74642
 3 | Alice Munro | t       | 2016-04-03 11:53:18.752364

```sql
SELECT * FROM addresses;
```
| user_id |     street      |     city      | state|
|---------|-----------------|---------------|-------|
     1 | 1 Market Street | San Francisco | CA
     2 | 2 Elm Street    | San Francisco | CA

```sql
SELECT * FROM users_books;
```
| user_id | book_id |       checkout_date        | return_date |
|---------|---------|----------------------------|-------------|
|       1 |       1 | 2017-10-11 12:34:31.921679 ||
|       1 |       2 | 2017-10-11 12:34:31.928207 ||
|       2 |       2 | 2017-10-11 12:35:33.821232 ||


```sql
-- All books and the users who checked them out
SELECT users.username, books.title
FROM users
RIGHT JOIN users_books ON (users_books.user_id = users.id)
RIGHT JOIN books ON (books.id = users_books.book_id);
```

Why does this not work?
```sql
/* missing FROM-clause entry for table "users_books" */
SELECT users.username, books.title
FROM users
RIGHT JOIN books ON (books.id = users_books.book_id)
RIGHT JOIN users_books ON (users_books.user_id = users.id);
```

Let's break it down.

```sql
/* Adding additional info to SELECT to show more data */
SELECT u.id, u.username
FROM users u
```

`FROM users` brings in this data to start off our intermediary/virtual? table.

| id |  username   |
|----|-------------|
| 1 | John Smith  |
| 2 | Jane Smiley |
| 3 | Alice Munro |

Our end goal is to find all book titles as well, so we might be tempted to try this JOIN next.

```sql
RIGHT JOIN books ON (books.id = users_books.book_id)
```

This would make books available to our table-in-progress, but we have no access to `users_books` yet, which would cause this error to throw `missing FROM-clause entry for table "users_books"`. Instead we need to first access a table that provides both user ids and book ids to provide a link between users and books. The  `users_book` tabe (essentially book checkouts) has this data, so instead we first write a JOIN between our `users` to `user_books` tables.

 ```sql
/* Updating SELECT to show additional data */
 SELECT u.id, u.username, ub.user_id, ub.book_id
 ...
 RIGHT JOIN users_books ub ON (users_books.user_id = users.id)
 ```
The above query supplies table data basically equivalent to this:

|id |  username   | user_id | book_id|
|----+-------------+---------+---------|
| 1 | John Smith  |       1 |       1|
| 1 | John Smith  |       1 |       2|
| 2 | Jane Smiley |       2 |       2|

Now it's time to find match the books our user's checked out to users. The next JOIN continues add data to our join table.
```sql
SELECT u.id, u.username, ub.user_id, ub.book_id, b.id AS book_table_id, b.title
...
RIGHT JOIN books b ON (b.id = ub.book_id);
```
id |  username   | user_id | book_id | book_table_id |       title   |     
----+-------------+---------+---------+---------+--------------------
| 1 | John Smith  |       1 |       1 |       1 | My First SQL book  |
| 1 | John Smith  |       1 |       2 |       2 | My Second SQL book |
| 2 | Jane Smiley |       2 |       2 |       2 | My Second SQL book |
|   |             |         |         |       3 | My Third SQL book  |

This is the full query rather than the diff if that helps

```sql
SELECT u.id, u.username, ub.user_id, ub.book_id, b.id AS book_id, b.title
FROM users u
RIGHT JOIN users_books ub ON (ub.user_id = u.id)
RIGHT JOIN books b ON (b.id = ub.book_id);
```

Then all you need to do is be more selective with what data you show by changing your SELECT query to the below:

```sql
SELECT users.username, books.title
```

Which gets you this:

```sql
|  username   |       title        |
|-------------|--------------------|
| John Smith  | My First SQL Book  |
| John Smith  | My Second SQL Book |
| Jane Smiley | My Second SQL Book |
|             | My Third SQL Book  |
```

Switching this to a LEFT JOIN would

|  username   |       title        |
|-------------|--------------------|
| John Smith  | My First SQL Book  |
| John Smith  | My Second SQL Book |
| Jane Smiley | My Second SQL Book |
|             | My Third SQL Book  |

```sql
/* Users who have checked out books */
SELECT COUNT(DISTINCT users_books.user_id) / COUNT(DISTINCT users.id)::float * 100 AS percent
  FROM users
  LEFT OUTER JOIN users_books ON users_books.user_id = users.id;
```

```sql
SELECT users.*, users_books.user_id
  FROM users
  LEFT OUTER JOIN users_books ON users_books.user_id = users.id;
```

id |  username   | enabled |         last_login         | user_id
----+-------------+---------+----------------------------+---------
 1 | John Smith  | t       | 2017-10-11 12:34:31.910787 |       1
 1 | John Smith  | t       | 2017-10-11 12:34:31.910787 |       1
 2 | Jane Smiley | t       | 2017-10-11 12:35:33.816738 |       2
 3 | Alice Munro | t       | 2017-10-11 12:35:44.640613 |        
(4 rows)
-
