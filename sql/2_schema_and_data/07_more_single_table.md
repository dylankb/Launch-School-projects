3) Write a SQL query to list the ten states with the most rows in the people table in descending order.

```sql
SELECT state, COUNT(id)
FROM people
GROUP BY state
ORDER BY count DESC
LIMIT 10;
```

```sql
SELECT state, count(state) AS state_count
FROM people
GROUP BY state
ORDER BY state_count DESC;
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
UPDATE people
SET given_name = UPPER(given_name)
WHERE email
LIKE '%teleworm.us';
```

```sql
UPDATE people
SET given_name = upper(given_name)
WHERE substr(email, strpos(email,'@') + 1) = 'teleworm.us';
```
