1) Create a sequence

```sql
CREATE SEQUENCE counter;
```

2) Find sequences next value

```sql
SELECT nextval('counter')
```

3) Remove sequence

```sql
DROP SEQUENCE counter;
```

4) Create a sequence that increments by two

```sql
CREATE SEQUENCE even_counter INCREMENT BY 2 MINVALUE 2;
```

6) Write a SQL statement to add an auto-incrementing integer primary key column to the films table.

```sql
ALTER TABLE films
 ADD COLUMN id serial PRIMARY KEY;
```

9) Write a SQL statement that modifies the table films to remove its primary key while preserving the id column and the values it contains.

```sql
ALTER TABLE films DROP CONSTRAINT films_pkey;
```
