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

5) Insert rows

INSERT INTO birds VALUES ('Spotted Towhee', 21.6, 26.7, 'Emberizidae', false);
INSERT INTO birds VALUES ('American Robin', 25.5, 36.0, 'Turdidae', false);
INSERT INTO birds VALUES ('Greater Koa Finch', 19.0, 24.0, 'Fringillidae', true);
INSERT INTO birds VALUES ('Carolina Parakeet', 33.0, 55.8, 'Psittacidae', true);
INSERT INTO birds VALUES ('Common Kestrel', 35.5, 73.5, 'Falconidae', false);

6) Find average, min and max of wingspan.

`SELECT round(avg(wingspan), 1), min(wingspan), max(wingspan) FROM birds;`

7)
SELECT item FROM menu_items WHERE max(menu_price - ingredient_cost);

SELECT item, menu_price, ingredient_cost, round((prep_time/60 * 13),2) AS labor, (menu_price - ingredient_cost + round((prep_time/60 * 13),2) AS profit
FROM menu_items
ORDER BY profit DESC;
