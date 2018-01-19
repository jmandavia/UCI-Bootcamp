use sakila

select first_name, last_name from actor 

select CONCAT(first_name, ' ', last_name) as Actor_Name from actor

select  actor_id, first_name, last_name from actor
where first_name = 'Joe'

select  actor_id, first_name, last_name from actor
where last_name like '%Gen%'

select last_name, first_name from actor
where last_name like '%Li%'

select country_id, country from country
where country in ('Bangladesh', 'Afghanistan', 'China')

ALTER TABLE actor
ADD middle_name VARCHAR(50);

ALTER TABLE actor MODIFY COLUMN middle_name VARCHAR(50) AFTER first_name;

ALTER TABLE actor modify COLUMN middle_name BLOB;

ALTER TABLE actor DROP middle_name;

SELECT COUNT(actor_id) as 'ct', last_name 
  FROM actor
 GROUP BY last_name

Select last_name from (
SELECT COUNT(actor_id) as 'ct', last_name 
  FROM actor
 GROUP BY last_name) tt
where ct >1

UPDATE actor
SET    first_name = 'Harpo'
WHERE  first_name = 'Groucho'

select *
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME='address'

#6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:
SELECT staff.first_name, staff.last_name, address.address
FROM staff
JOIN address ON staff.address_id=address.address_id;

#6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.
SELECT staff.first_name, staff.last_name, sum(payment.amount)
FROM staff
Join payment on staff.staff_id = payment.staff_id
where payment.payment_date like '2005-08%'
group by staff.first_name, staff.last_name

#6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
SELECT film.title, count(film_actor.actor_id)
FROM film
INNER JOIN film_actor ON film.film_id=film_actor.film_id
group by film.title;

#6d. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT film.title, count(inventory.inventory_id)
FROM film
Join inventory on film.film_id =inventory.film_id
where film.title like 'HUNCHBACK IMPOSSIBLE'
group by film.title;

#6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:
SELECT customer.last_name, customer.first_name, sum(payment.amount)
FROM customer
Join payment on payment.customer_id = customer.customer_id
group by customer.last_name, customer.first_name
order by customer.last_name;

#7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
Select film.title from film
where left(film.title,1) in ('Q', 'K') and film.language_id in (select language.language_id from language where name = 'english');

#7b. Use subqueries to display all actors who appear in the film Alone Trip.
Select actor.last_name, actor.first_name from actor
where actor.actor_id in (select actor_id from film_actor where film_id in (
Select film.film_id from film where film.title = 'ALONE TRIP'));

#7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.

select customer.last_name, customer.first_name, customer.email from customer 
where address_id in (select address_id from address where city_id  in (select city_id from city where country_id in (select country_id from country where country = 'canada')));