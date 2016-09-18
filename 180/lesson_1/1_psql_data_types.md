1. What kind of programming language is SQL?

Special purpose language

2. What are the three sublanguages of SQL?

Data Definition Language, Data Manipulation Language, and Data Control Language.

3. Write the following values as quoted string values that could be used in a SQL query.

canoe
a long road
weren't
"No way!"

'canoe'
'a long road'
'weren''t'
'"No way!"'

4. What function returns a lowercased version of a string? Write a SQL statement using it.

SELECT lower('CAPS');

5. What operator is used to concatenate strings?

```sql
library=# SELECT 'cat'||'dog';
 ?column?
----------
 catdog
(1 row)
```

6. How does the psql console display true and false values?

t and f

7. The surface area of a sphere is calculated using the formula A = 4π r2, where A is the surface area and r is the radius of the sphere.

`SELECT ROUND((4 * 3.14) * (26.3 * 26.3),0);`
or
`SELECT trunc(4 * pi() * 26.3 ^ 2);`

Use SQL to compute the surface area of a sphere with a radius of 26.3cm, truncated to return an integer.
