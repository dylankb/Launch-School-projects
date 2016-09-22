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
ORDER BY age ASC;
```
