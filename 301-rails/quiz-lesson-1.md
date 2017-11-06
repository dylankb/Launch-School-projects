1) Why do they call it a relational database?

A relational database persists data across multiple tables (or relations).

2) What is SQL?

Structured Query Language is a special purpose language for structuring, retrieving, and manipulating data from RDBMSs.

3) There are two predominant views into a relational database. What are they, and how are they different?

4) In a table, what do we call the column that serves as the main identifier for a row of data? We're looking for the general database term, not the column name.

A primary key (a unique, non-null key).

5) What is a foreign key, and how is it used?

A foreign key is usually the primary key from another column that's located on another table. It's used to tie data between multiple tables together. How it's used depends on the relationship types (cardinality), but for example in a one-to-many relationship, the foreign key will reside on the many side of the relationship.

6) At a high level, describe the ActiveRecord pattern. This has nothing to do with Rails, but the actual pattern that ActiveRecord uses to perform its ORM duties.

ActiveRecord is an implementation of an object relation mapper (ORM). It has the ability to transform data from relational databases (commonly a row of data) into objects. Columns on that row become the object's attributes.

7) If there's an ActiveRecord model called "CrazyMonkey", what should the table name be?

crazy_monkeys

8) If I'm building a 1:M association between Project and Issue, what will the model associations and foreign key be?

```rb
# modles/project.rb
class Project < ActiveRecord::Base
  has_many: issues
end
```
```rb
# modles/issue.rb
class Issue < ActiveRecord::Base
  belongs_to: project
end
```

The `issues` table will have a foreign key `project_id`.

9) Given this code

```
class Zoo < ActiveRecord::Base
 	  has_many :animals
end
```

a) What do you expect the other model to be and what does database schema look like?

The other model should be Animals. The two should have a One-to-Many relationship.

b) What are the methods that are now available to a zoo to call related to animals?

```rb
zoo.animals
zoo.animals.length
zoo.animals.exists?
...
```

c) How do I create an animal called "jumpster" in a zoo called "San Diego Zoo"?

```rb
sdzoo = Zoo.create(location: "San Diego")
sdzoo.animals.create(name: "jumpster")
# OR animals.create(name: "jumpster", zoo_id: sdzoo.id)
# OR sdzoo.animals.create(name: "jumpster", zoo: sdzoo)
```

d) What is mass assignment? What's the non-mass assignment way of setting values?

Mass assignment is creating an object and setting multiple values at once. In AR this would look like `Post.create(title: "Title", url: "www.google.com")`. The alternative is setting values one at a time on an object. If `p` represents on an instance of `Post`, then you use setters to add information, like `p.title="Title"`, etc.

10) Suppose Animal is an ActiveRecord model. What does this code do? Animal.first

Will return the first animal in the list of animals.

11) If I have a table called "animals" with a column called "name", and a model called Animal, how do I instantiate an animal object with name set to "Joe". Which methods makes sure it saves to the database?

12) How does a M:M association work at the database level?

You need to create a join table in order to create pairings of foreign keys. This join table represents the relationship between the two tables.

13) What are the two ways to support a M:M association at the ActiveRecord model level? Pros and cons of each approach?

Has Many And Belongs To Many - Pros: less typing. Cons: Cannot add additional columns or a join model in the future. Also does not allow you to use conveniences provided by join models, such as validation and callbacks.

Has Many Through - Pros: Allows you to continue adding columns and use join model features. Cons: you need to create a join model and appropriately name the join model/table.

14) Suppose we have a User model and a Group model, and we have a M:M association all set up. How do we associate the two?
