1) What's the difference between rendering and redirecting? What's the impact with regards to instance variables, view templates?

There are two types of responses to an HTTP request: a render or a redirect. A redirect issues a new HTTP request. Since a HTTP request is stateless, any instance variables that were instantiated will be lost. A rendering a view is a method call, and therefore allows existing instance variables to remain.

2) If I need to display a message on the view template, and I'm redirecting, what's the easiest way to accomplish this?

Use ActionDispatch::Flash. Call `flash` to save a message with a session. The message displays in the next action and then disappears after that.

3) If I need to display a message on the view template, and I'm rendering, what's the easiest way to accomplish this?

`flash.now` will be displayed in current action (next render), but not the next action.

4) Explain how we should save passwords to the database.

Passwords should never be saved in plain text.

Instead you should install an encryption library, such as the `bcrypt` gem to encrypt save encryptions into the database. The model which holds the column for our passwords should call `has_secure_password`, which will allow us to create a 'one-way-hash'. The passwords string column should be named `password_digest`.

7) What should we do if we have a method that is used in both controllers and views?

First, you might consider consolidating them in one location if appropriate.

If that's not possible, moving the method to the `application_controller`

8) What is memoization? How is it a performance optimization?

Memoization is the practice of instantiating or calling a method only when you need to. If a particular call triggers a db query, then that can certainly have an impact on performance.

10) If we want to prevent unauthenticated users from creating a new comment on a post, what should we do?

Here are a couple things:

- Create a `require_user` before action on the action that would process that request.
- Hide the create comment form unless a user was signed in.

11) Suppose we have the following table for tracking "likes" in our application. How can we make this table polymorphic? Note that the "user_id" foreign key is tracking who created the like.

id|user_id|photo_id|video_id|post_id
--|-------|--------|--------|-------
1 |4||12| |
2 |7| | |3|
3 |2|6| | |		

Create a `likes` table with a `likeable_type` and `likeable_id`.

12_ How do we set up polymorphic associations at the model layer? Give example for the polymorphic model (eg, Vote) as well as an example parent model (the model on the 1 side, eg, Post).

Add this line to your `likes` model - `belongs_to: voteable, polymorphic: true`

In the parent models, do something like this:

```rb
class Post
  has_many :votes, as: :voteable
end
```

What is an ERD diagram, and why do we need it?

An entity relationship diagram allows us to visualize the relationships between different entities in our application. The visualization often also includes details about the relationship, such as cardinality. Depending on the level of detail in the ERD diagram, it may also include attributes for each of the entities or even the column names and data types if it's a physical ERD that's aimed at mapping out an implementation.
