1) What is the result of using an operator on a NULL value?

The resulting value will also be NULL, which signifies an unknown value.

2) Set the default value of column department to "unassigned". Then set the value of the department column to "unassigned" for any rows where it has a NULL value. Finally, add a NOT NULL constraint to the department column.

```sql
ALTER TABLE employees
ALTER COLUMN department
SET DEFAULT 'unassigned';

UPDATE employees
SET department = 'unassigned'
WHERE department IS NULL;

ALTER TABLE employees
ALTER COLUMN department
SET NOT NULL;
```

5) Query to find mean temperature

Average temperature
```sql
SELECT round((AVG(low) + AVG(high)) / 2, 2) AS average_temperature
FROM temperatures;
```

Average temperatures by day
```sql
SELECT date, (low + high) / 2 AS average_temperature
FROM temperatures;
```

7) Each day, it rains one millimeter for every degree the average temperature goes above 35. Write a SQL statement to update the data in the table temperatures to reflect this.

```sql
UPDATE temperatures
   SET rainfall = (high + low) / 2 - 35
 WHERE (high + low) / 2 > 35;
```

8) Convert rainfall to inches

```sql
ALTER TABLE temperatures ALTER COLUMN rainfall TYPE numeric(6,3);
UPDATE temperatures
   SET rainfall = rainfall * 0.0393701;
```

9) Rename table to weather

```sql
ALTER TABLE temperatures RENAME TO weather;
```

10) How would you export the data and structure of the table

`pg_dump -d sql-course -t weather --inserts > dump.sql`
