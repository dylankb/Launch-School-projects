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
    wingspan numeric(4,1), /* or decimal */
    family text,
    extinct boolean
);
```

5)

```sql
SELECT name, family
FROM birds
WHERE extinct=false  /* Or IS false */
ORDER BY length DESC;
```

6) Find average, min and max of wingspan.

`SELECT round(avg(wingspan), 1), min(wingspan), max(wingspan) FROM birds;`

7)

```sql
CREATE table menu (

)
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
