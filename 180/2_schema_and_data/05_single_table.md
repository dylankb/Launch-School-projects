1. Create a table with name age	occupation columns.

```sql
CREATE TABLE people (
  name varchar(255),
  age integer,
  occupation varchar(255)
);
```

2. Write SQL statements to insert the data shown in #1 into the table.

```sql
INSERT INTO people (name, age, occupation) VALUES ('Abby', 34, 'biologist');
INSERT INTO people (name, age) VALUES ('Mu''nisah', 26);
INSERT INTO people (name, age, occupation) VALUES ('Mirabelle', 40, 'contractor');
```

3. Write 3 SQL queries that can be used to retrieve the second row of the table shown in #1 and #2.

```sql
SELECT * FROM people WHERE age = 26;
SELECT * FROM people WHERE name = 'Mu''nisah';
SELECT * FROM people WHERE occupation IS NULL;
SELECT * FROM people ORDER BY occupation DESC;
```

4. Write a table for these columns: name,	length,	wingspan,	family,	extinct.

```sql
CREATE TABLE birds (
  name varchar(255), /* character varying */
  length numeric(4,1),
  wingspan numeric(4,1),
  family varchar(255),
  extinct boolean
);
```

5) Insert data

```sql
INSERT INTO birds VALUES ('Spotted Towhee', 21.6, 26.7, 'Emberizidae', false);
INSERT INTO birds VALUES ('American Robin', 25.5, 36.0, 'Turdidae', false);
INSERT INTO birds VALUES ('Greater Koa Finch', 19.0, 24.0, 'Fringillidae', true);
INSERT INTO birds VALUES ('Carolina Parakeet', 33.0, 55.8, 'Psittacidae', true);
INSERT INTO birds VALUES ('Common Kestrel', 35.5, 73.5, 'Falconidae', false);
```

6)

```sql
SELECT name, family
FROM birds
WHERE extinct=false  /* Or IS false */
ORDER BY length DESC;
```

7) Find average, min and max of wingspan.

```sql
SELECT round(avg(wingspan), 1), min(wingspan), max(wingspan) FROM birds;
```

8)

```sql
CREATE TABLE menu_items (
    item text,
    prep_time integer,
    ingredient_cost numeric(4,2),
    sales integer,
    menu_price numeric(4,2)
);
```

9)

```sql
INSERT INTO menu VALUES ('omelette', 10, 1.50, 182, 7.99);
INSERT INTO menu VALUES ('tacos', 5, 2.00, 254, 8.99);
INSERT INTO menu VALUES ('oatmeal', 1, 0.50, 79, 5.99);
```

10) Determine profitability of each menu item

Greatest gross profit for sale
```sql
SELECT item FROM menu WHERE max(menu_price - ingredient_cost);
```

Highest profitability item
```sql
SELECT item, (ingredient_cost/menu_price) AS profitability FROM menu ORDER BY profitability LIMIT 1;
```

11) Most profitable by time to prepare

```sql
SELECT item,
       ingredient_cost,
       round((prep_time * 13.0) / 60, 2) AS labor_cost, /* Now way to pass down AS variables in select? */
       round((prep_time * 13.0) / 60, 2) + ingredient_cost AS unit_cost,
       round((1 - ((round((prep_time * 13.0) / 60, 2) + ingredient_cost) / menu_price)) * 100, 2) AS profitability
FROM menu
ORDER BY profitability DESC;
```
