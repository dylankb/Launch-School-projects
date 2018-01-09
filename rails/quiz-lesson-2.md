1) Name all the 7 (or 8) routes exposed by the resources keyword in the routes.rb file. Also name the 4 named routes, and how the request is routed to the controller/action.

Name       |  URI             | Verb
-----------|------------------|------
posts      | /posts           | GET
posts      | /posts           | POST
new_post   | /posts/new       | GET
edit_post  | /posts/:id/edit  | GET
post       | /post/:id        | GET
post       | /post/:id        | PUT
post       | /post/:id        | DELETE

When a request is received by a Rails application, the request references existing routes in the `config/routes.rb` file, maps the it to the applicable controller action.

2) What is REST and how does it relate to the resources routes?

REST is a pattern or convention for exposing URL endpoints (APIs) so requests can be mapped to actions on resources. With a restful design, any action a user needs to make can me accomplished on or many resources.

3) What's the major difference between model backed and non-model backed form helpers?

Model back form can take a ActiveRecord object or objects and dynamically set the form's action and method. There has to be a setter method, a virtual attribute, or a column in the database available to the object.

4) How does form_for know how to build the <form> element?

The form_for method can tell what the current route, and when combined with ActiveRecord object(s) it can determine the appropriate method and action.

5) What's the general pattern we use in the actions that handle submission of model-backed forms (i.e, the create and update actions)?

- Set up necessary instance variables in new/edit actions
- Take resource parameters to create a new object in memory
- If the object can be saved, then flash a success notice and redirect
- If there are errors, render the template the form submission came from.

6) How exactly do Rails validations get triggered? Where are the errors saved? How do we show the validation messages on the user interface?

Rails validations are triggered when an ActiveRecord object is saved (it tries to persist the object, or in other words write to the database).

Errors are stored on the object in memory, usually an instance variable. A common pattern is to loop through the error messages in an error partial above the form, which displays conditionally on the presence of errors.

Additionally, form helpers create additional elements around the problematic inputs if the developer wants to highlight specific input fields for the user.

7) What are Rails helpers?

Rails helpers contain presentation-level logic that can be used throughout the application.

8) What are Rails partials?

Rails partial are ERB files contained in the views directory. They abstract common presentation layout, content, or elements that need to be used across multiple views and/or simplify the view.

9) When do we use partials vs helpers?

Helpers are for logic heavy presentational concerns that do not require much HTML.

10) When do we use non-model backed forms?

One example would be when you're not interfacing with the resource directly (performing a CRUD action), like with a sign in form. We can think of a non-model backed form as generating pure HTML rather than binding the form with a model object.
