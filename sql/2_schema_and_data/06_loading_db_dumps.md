4) Write the SQL statements needed to add two additional columns to the films table: director, which will hold a director's full name, and duration, which will hold the length of the film in minutes.

```sql
ALTER TABLE films ADD COLUMN director varchar(255);
ALTER TABLE films ADD COLUMN duration integer;
```

5) Update to include additional data

```sql
UPDATE films SET director = 'John McTiernan' WHERE title = 'Die Hard';
...
```

7) Return the newest movie first

| title	|year|genre|director|duration |
|-----|----|-----|--------|--------|
| 1984|1956|scifi|Michael Anderson| 90 |
| Tinker Tailor Soldier Spy|2011|espionage|Tomas Alfredson|	127 |
| The Birdcage|1996|comedy|Mike Nichols|118 |

```sql
SELECT title, date_part('year', current_date) - year AS age
FROM films
ORDER BY age;
```

```sql
SELECT title, extract(year from current_date) - year AS age
FROM films
ORDER BY age ASC; /* ASC is optional */
```

8) Write a SQL statement that will return the title and duration of each movie longer than two hours, with the longest movies first.

```sql
SELECT title, duration
FROM films
WHERE duration > 120
ORDER BY duration DESC;
```
