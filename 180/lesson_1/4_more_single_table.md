3) Write a SQL query to list the ten states with the most rows in the people table in descending order.

```sql
SELECT state, COUNT(id)
FROM people
GROUP BY state
ORDER BY count DESC
LIMIT 10;
```

4. Unique domains and the number of people with them

```sql
SELECT SUBSTRING(email,'@[0-9a-z]+.[a-z]+') as domain, COUNT(id)
FROM people
GROUP BY domain;
```

```sql
SELECT substr(email, strpos(email,'@') + 1) as domain, COUNT(id)
FROM people
GROUP BY domain;
```

7. Change column's values based if email is a certain domain

```sql
UPDATE given_name
FROM people
SET upper(given_name)
WHERE substr(email, strpos(email,'@') + 1) = 'teleworm.us';
```
