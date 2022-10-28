# Travel destinations

## Mid-term Team Project for Skill Distillery

### Team members and roles:

* Josh Ingram (Developer, DBA)
* Aspen Newman (Developer, Scrum Master)
* Celicia Slafter (Developer, Repo Owner)

## Overview
This web based application allows travel enthusiasts to discover and share exciting new destinations.  

## Description  
  * Without being logged in, the user can:
      * access the welcome page
      * create an account

  * Once logged in, the user can:
      * create a new travel destination
      * update their destinations
      * delete their destinations
      * leave reviews for any destination
      * submit photos
      * leave a review
      * comment on reviews
      * logout to complete their session
      * delete their account


  * Destination information includes:
      * name
      * description
      * date created
      * last edited
      * address
      * category(s)
      * features
      * pictures with caption, creating user, and created date
      * official website link
      * pricing information, including currency, amount, and pricing type
      * reviews with creating user and created date
      * comments on reviews with creating user and created date

  * A user's personal profile page shows account details including:
      * bio
      * date created
      * destinations created
      * quick link to update or delete their account
      * quick links to view or update their submitted content   

  * Users with administrator roles can:
      * disable users
      * reinstate users
      * edit user submitted content (destinations, reviews, comments, etc.)
      * remove user submitted content (destinations, reviews, comments, etc.)

Welcome Page:
![Welcome page](https://github.com/clslafter/MidtermProject/blob/main/Screen%20Shot%20Welcome%20page.png)

Sample Destination Page:
![Sample destination page](https://github.com/clslafter/MidtermProject/blob/main/Screen%20Shot%20Destination%20page.png)

## Implementation

We began this project by putting our ideas into a Trello board in the form of discreet user stories following a CRUD outline and then adding bullet points for each user story into a checklist. Concurrently, we also used a Figma wireframe to outline the individual web page functions and connections.

Following that, we created and populated the database tables and relationships through MySql Workbench and built the foundation of the project with Beans using test-driven development.

After the foundation was created, we alternated between splitting the work and swarming to develop the CRUD for both the User and Destination sides of the project.

Once we had a minimum viable product in terms of functionality, we implemented a few stretch goals, then designed and styled the individual pages using CSS and Bootstrap.

ER DIAGRAM:
![Photo of ER diagram](https://github.com/clslafter/MidtermProject/blob/main/DB/destinationsdb.png)

## Technologies and Methodologies Used:
### Technologies/Frameworks:
  * Java
  * MySQL
  * HTML
  * CSS
  * SQL
  * JPQL
  * MySQL Workbench
  * Atom
  * Bootstrap
  * Unix Terminal
  * Spring
  * Spring Boot
  * JPA
  * Spring Tools Suite
  * Chrome
  * git/gitHub
  * Slack
  * Zoom  
  * Trello
  * Figma

### Methodologies:
  * Pair Programming
  * Agile
  * Kanban
  * git collaboration

## Lessons Learned:
Communicate openly and honestly
  * to ensure alignment on goals/features
  * to prevent merge conflicts
  * seek input and ask for help (early)
  * to encourage teammates and provide feedback

Keep priorities straight and track in Kanban -  core functions, then minimum viable product, then stretch goals.

Set realistic goals - distinguish between stretch goals and mvp early.

The importance of making sure the input names in the jsp forms are exactly like the object fields in order to create a command line object becomes more apparent as the code gets more complicated.

Idea of pulling in a full object and populating it with its id

## Stretch Goals Implemented:
  * Implemented dynamic nav bar with logo
  * We added sort and search functionality for the destinations on the home page
  * We gave users the ability to add, edit, and delete additional photos for each destination
  * User can view each other's profiles
  * Admins can enable or disable a user, as well as edit or remove a destination, review, comment, or photo

## How to Download and Run
Go to:
http://52.40.152.6:8080/Destinations/

Guests can create their own account or log in as:
* username: normaluser
* password: 1234

Have a look around!
