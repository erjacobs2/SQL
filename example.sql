USE sakila

SELECT * FROM sakila.actor;

-- All first and last names from actors
SELECT first_name, last_name FROM actor;

-- Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.

-- Adds new column to actor table
ALTER TABLE actor
ADD Actor_Name VARCHAR(50);

 -- SELECT CONCAT('first_name', 'last_name');
 -- Create content of Actor_Name column
 SELECT CONCAT(first_name, ' ', last_name) AS Actor_Name FROM actor;
 
 -- ALTER TABLE actor ADD actor_name AS (first_name + ' ' + last_name)
 
-- NSERT INTO actor (Actor_Name)
 -- SELECT CONCAT(first_name, ' ', last_name) AS Actor_Name FROM actor;

SELECT * FROM sakila.actor;

-- SELECT UPPER(CustomerName) AS UppercaseCustomerName
-- FROM Customers;

-- 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?

SELECT * FROM sakila.actor
WHERE first_name = 'Joe';

-- 2b. Find all actors whose last name contain the letters GEN:

SELECT * FROM sakila.actor
WHERE last_name LIKE '%gen%';

-- 2c. Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:

SELECT * FROM sakila.actor
WHERE last_name LIKE '%li%';

-- SELECT UPPER(CustomerName) AS UppercaseCustomerName
-- FROM Customers;

-- 2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:

SELECT * FROM sakila.country
WHERE country = 'Afghanistan'
OR country = 'Bangladesh'
OR country = 'China';

-- 3a. You want to keep a description of each actor. You don't think you will be performing queries on a description, so create a column in the table actor named description and use the data type BLOB (Make sure to research the type BLOB, as the difference between it and VARCHAR are significant).

ALTER TABLE actor
ADD Description BLOB(50);

-- 3b. Very quickly you realize that entering descriptions for each actor is too much effort. Delete the description column.

ALTER TABLE actor
DROP Description;

-- 4a. List the last names of actors, as well as how many actors have that last name.

SELECT last_name, COUNT(last_name) FROM sakila.actor
GROUP BY last_name;

-- 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors

SELECT last_name, COUNT(last_name) FROM sakila.actor
GROUP BY last_name
HAVING COUNT(last_name) >= 2;

-- 4c. The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. Write a query to fix the record.

UPDATE actor
SET first_name = "HARPO"
WHERE first_name = "GROUCHO";

-- 4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO.

UPDATE actor
SET first_name = "GROUCHO"
WHERE first_name = "HARPO";

-- 5a. You cannot locate the schema of the address table. Which query would you use to re-create it?

SELECT * FROM sakila.address;

CREATE TABLE address (
  address_id INT AUTO_INCREMENT NOT NULL,
  address VARCHAR(50),
  address2 VARCHAR(30),
  district VARCHAR(40),
  city_id INT,
  postal_code INT,
  phone INT,
  location BLOB(30),
  last_update INT,
  PRIMARY KEY (address_id)
);

-- 6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:

SELECT * FROM sakila.staff;

SELECT staff.first_name, staff.last_name, staff.address_id, address.address
FROM staff
INNER JOIN address ON
address.address_id=staff.address_id;

-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.

SELECT staff.first_name, staff.last_name, staff.staff_id, payment.amount
FROM staff
INNER JOIN payment ON
staff.staff_id=payment.payment_id;

-- 6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.

SELECT film.title, film_actor.actor_id
FROM film
INNER JOIN film_actor ON
film.film_id=film_actor.film_id;

-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system?

SELECT * FROM film;
SELECT * FROM inventory;

SELECT film.title, inventory.inventory_id
FROM film
INNER JOIN film ON
film.film_id = inventory.film_id;

-- 6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:

SELECT film.title, film_actor.actor_id
FROM film
INNER JOIN film_actor ON
film.film_id=film_actor.film_id;

-- 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.

select * from film;

SELECT * FROM film
WHERE title IN
(
	select title
    from film
    where language_id = 1
    and title like 'k%' or 'Q%'
);

-- 7b. Use subqueries to display all actors who appear in the film Alone Trip.
SELECT * FROM film_actor
WHERE actor_id IN
(
	select title
    from film
    where language_id = 1
    and title like 'k%' or 'Q%'
);

-- 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.

SELECT film.title, inventory.inventory_id
FROM film
INNER JOIN film ON
film.film_id = inventory.film_id;

-- 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.

SELECT * FROM sakila.film_category;

SELECT category_id FROM film_category
WHERE film_category = 3;

-- 7e. Display the most frequently rented movies in descending order.

SELECT rental_id FROM rental
GROUP BY iventory_id;

-- 7f. Write a query to display how much business, in dollars, each store brought in.


-- 7g. Write a query to display for each store its store ID, city, and country.


-- 7h. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)


-- 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.


-- 8b. How would you display the view that you created in 8a?


-- 8c. You find that you no longer need the view top_five_genres. Write a query to delete it.