1) All books and the users who checked them out

```sql
SELECT users.username, books.title
FROM users
RIGHT JOIN users_books ON (users_books.user_id = users.id)
RIGHT JOIN books ON (books.id = users_books.book_id);
```

2) Percentage of users who have checked out books
```sql
SELECT COUNT(DISTINCT users_books.user_id) / COUNT(DISTINCT users.id)::float * 100 AS percent
  FROM users
  LEFT OUTER JOIN users_books ON users_books.user_id = users.id;
```

3) Counts of book checkouts by user

```sql
SELECT users.username, (SELECT COUNT(user_id) FROM users_books WHERE users_books.user_id = users.id)
FROM users;

/* JOIN version */
SELECT users.username, COUNT(user_id)
  FROM users
       LEFT OUTER JOIN users_books ON (users_books.user_id = users.id)
GROUP BY users.username;
```

4) The most checked out book



4) Count of books that were reviewed
```sql
SELECT COUNT(DISTINCT books.title)
FROM reviews
  INNER JOIN books ON (books.id = reviews.book_id);
```

```sql
/* Test query */
SELECT reviews.id, reviews.review_content, books.title
FROM reviews
  INNER JOIN books ON (books.id = reviews.book_id);
```

5) Find books that haven’t been checked out
```sql
SELECT books.*, users_books.*
FROM books
  LEFT JOIN users_books ON books.id = users_books.book_id
WHERE users_books.checkout_date IS NULL;
```

6) Find most active library user (who's checked out the most books)

```sql
SELECT * FROM users
WHERE id = (SELECT user_id
FROM users_books
GROUP BY user_id
ORDER BY COUNT(*) DESC
LIMIT 1);
````

```sql
SELECT users.*
FROM users
INNER JOIN users_books ON (users_books.user_id = users.id)
GROUP BY users_books.user_id
ORDER BY COUNT(*) DESC
LIMIT 1
```

```sql
SELECT users.*
FROM users
INNER JOIN users_books ON (users_books.user_id = users.id)
GROUP BY users.id
ORDER BY COUNT(*) DESC
LIMIT 1
```

7) Users who checked out books

```sql
SELECT users.id, users.username
FROM users
WHERE users.id IN
(SELECT DISTINCT(users_books.user_id)
FROM users_books);
```

```sql
SELECT DISTINCT(users.id), users.username
FROM users
INNER JOIN users_books ON (users_books.user_id = users.id);
```

```sql
SELECT users.id, users.username
FROM users
INNER JOIN users_books ON (users_books.user_id = users.id)
GROUP BY users.id;
```
