# Travel destinations

## Mid-term Team Project for Skill Distillery

### Team members and roles:

* Josh Ingram (Developer, DBA)
* Aspen Newman (Developer, Scrum Master)
* Celicia Slafter (Developer, Repo Owner)

## Overview
This web based application allows travel enthusiasts to discover and share exciting new destinations.  

## Description  
Without logging in, the user is able to browse travel destinations submitted by other users.  Destinations include information such as the address, category(s), features, pictures, official website link, and pricing information.  Once logged in (by means of creating their own account), the user is able to create a new travel destination, update their destinations, and delete their destinations.  A logged-in user is also able to leave reviews for any destination, as well as submit photos, leave a review, and comment on reviews.  A user's personal profile page shows their account details as well as quick links to view or update their submitted content.   The user can logout to complete their session as well as delete their account.  Users with administrator roles can disable users, reinstate users, and edit or remove user submitted content (destinations, reviews, comments, etc.).

//SCREEN SHOTS GO HERE//

## Implementation

We began this project by putting our ideas into a Trello board in the form of discreet user stories following a CRUD outline and then adding bullet points for each user story into a checklist. Concurrently, we also used a figma wireframe to outline the individual web page functions and connections.

Following that, we created and populated the database tables and relationships through MySql Workbench and built the foundation of the project with Beans using test-driven development.

After the foundation was created, we alternated between splitting the work and swarming to develop the CRUD for both the User and Destination sides of the project.

Once we had a minimum viable product in terms of functionality, we designed and styled the individual pages using CSS and Bootstrap.

//ER DIAGRAM PNG GOES HERE//

## Technologies and Methodologies Used:
### Technologies/Frameworks:
  * Java
  * MySQL
  * HTML
  * CSS
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
  * SQL
  * JPQL
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

## Stretch Goals Implemented:
  * We created an app name and chose a logo
  * We added sort and search functionality for the destinations on the home page
  * We gave users the ability to add, edit, and delete additional photos for each destination

## How to Download and Run
Go to:
http://52.40.152.6:8080/Destinations/

Guests can create their own account or log in as:
* username: normaluser
* password: 1234

Have a look around!
