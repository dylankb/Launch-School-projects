1. Create a table with name age	occupation columns.

`CREATE TABLE people (name varchar(255), age integer, occupation varchar(255));`

2. Write SQL statements to insert the data shown in #1 into the table.

`INSERT INTO people (name, age, occupation) VALUES ('Abby', 34, 'biologist');`

3.

4. Write a table for these columns name	length	wingspan	family	extinct

```sql
CREATE TABLE birds (name varchar(255), length numeric(4,1), wingspan numeric(4,1), family varchar(255), extinct boolean);

CREATE TABLE birds (
    name character varying(255),
    length numeric(4,1),
    wingspan numeric(4,1),
    family text,
    extinct boolean
);
```

6) Find average, min and max of wingspan.

`SELECT round(avg(wingspan), 1), min(wingspan), max(wingspan) FROM birds;`

7)

```sql
SELECT item FROM menu_items WHERE max(menu_price - ingredient_cost);

SELECT item, menu_price, ingredient_cost, round((prep_time/60 * 13),2) AS labor, (menu_price - ingredient_cost + round((prep_time/60 * 13),2) AS profit
FROM menu_items
ORDER BY profit DESC;
```
