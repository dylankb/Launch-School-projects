3) Write a SQL query that lists all genres for which there is a movie in the films table.

```sql
SELECT DISTINCT genre FROM films;
/* OR */
SELECT genre FROM films GROUP BY genre;
```

5) Find average duration to nearest minute.

```sql
SELECT ROUND(AVG(duration)) FROM films;
```

6) Find average duration by genre.

```sql
SELECT genre, ROUND(AVG(duration)) FROM films GROUP BY genre;
```

7) First name John directors

```sql
SELECT * FROM films WHERE director LIKE 'John %';
/* OR */
SELECT director
  FROM films
 WHERE position('John' in director) BETWEEN 1 AND position(' ' in director);
```

8) Count of movies by genre

```sql
SELECT genre, COUNT(id) FROM films GROUP BY genre ORDER BY count DESC;
/* OR */
SELECT genre, COUNT(genre) FROM films GROUP BY genre ORDER BY count DESC;
```

10)

```sql
SELECT (year - year % 10) AS decade, genre, string_agg(title, ', ') AS films_title
  FROM films GROUP BY decade, genre ORDER BY decade, genre;

/* Group by fails  */
SELECT (year - year % 10) AS decade, genre, title
  FROM films GROUP BY decade ORDER BY decade;
```

  decade |   genre   |           title           
 --------+-----------+---------------------------
    1940 | drama     | Casablanca
    1950 | scifi     | 1984
    1950 | drama     | 12 Angry Men
    1970 | crime     | The Godfather
    1970 | thriller  | The Conversation
    1980 | action    | Die Hard
    1980 | comedy    | Hairspray
    1990 | comedy    | The Birdcage
    1990 | comedy    | Home Alone
    1990 | comedy    | Wayne's World
    1990 | scifi     | Godzilla
    2000 | espionage | The Bourne Identity
    2000 | horror    | 28 Days Later
    2010 | scifi     | Godzilla
    2010 | espionage | Tinker Tailor Soldier Spy
    2010 | scifi     | Interstellar
    2010 | scifi     | Midnight Special


```sql
SELECT year / 10 * 10 AS decade, genre, string_agg(title, ', ') AS films
  FROM films GROUP BY decade, genre ORDER BY decade, genre;
```
decade |   genre   |               films_title                
--------+-----------+------------------------------------------
  1940 | drama     | Casablanca
  1950 | drama     | 12 Angry Men
  1950 | scifi     | 1984
  1970 | crime     | The Godfather
  1970 | thriller  | The Conversation
  1980 | action    | Die Hard
  1980 | comedy    | Hairspray
  1990 | comedy    | The Birdcage, Wayne's World, Home Alone
  1990 | scifi     | Godzilla
  2000 | espionage | The Bourne Identity
  2000 | horror    | 28 Days Later
  2010 | espionage | Tinker Tailor Soldier Spy
  2010 | scifi     | Midnight Special, Godzilla, Interstellar

11)

```sql
  SELECT genre, SUM(duration) AS total_duration
    FROM films
GROUP BY genre
ORDER BY total_duration;
```
