4) Ensure title column has a unique value for each film.

```sql
ALTER TABLE films ADD CONSTRAINT title_unique UNIQUE (title);
```

7) Add a constraint to films that requires all rows to have a value for title that is at least 1 character long.

```sql
ALTER TABLE films ADD CONSTRAINT title_length CHECK (length(title) >= 1);
```

11) Add a constraint to the table films that ensures that all films have a year between 1900 and 2100.

```sql
   ALTER TABLE films
ADD CONSTRAINT year_range
         CHECK (year BETWEEN 1900 AND 2100); /* (year >= 1900 AND year <= 2100) */
```

13) Add a constraint to films that requires all rows to have a value for director that is at least 3 characters long and contains at least one space character.

```sql
ALTER TABLE films ADD CONSTRAINT director_name
    CHECK (length(director) >= 3 AND position(' ' in director) > 0);
```
```sql
ALTER TABLE films ADD CONSTRAINT director_name_check
         CHECK ((length(director)> 2)
           AND position(' ' in director) > 0);
```

16) List three ways to use the schema to restrict what values can be stored in a column.

1. Data type (which can include a length limitation)
2. `NOT NULL` Constraint
3. Check Constraint
