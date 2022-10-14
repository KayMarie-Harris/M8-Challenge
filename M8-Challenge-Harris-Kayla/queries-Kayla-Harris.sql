use sakila;

-- write a SQL query to find the total rental amount paid for each film. Should return columns film_id & total_amount
Select inventory.film_id,sum(payment.amount)as total_amount from inventory
join rental on inventory.inventory_id = rental.inventory_id
join payment on rental.rental_id = payment.rental_id GROUP BY inventory.film_id;

-- create  a view named total_rental_amount using the query from the previous step
create view total_rental_amount AS
Select inventory.film_id,sum(payment.amount)as total_amount from inventory
join rental on inventory.inventory_id = rental.inventory_id
join payment on rental.rental_id = payment.rental_id GROUP BY inventory.film_id;
	
-- write a SQL query to find the total number of copies in inventory for each film. Should return film_id, total_copies
SELECT film.film_id, count(inventory.film_id) as total_copies FROM film 
join inventory ON film.film_id = inventory.film_id GROUP BY film_id;

-- create a view named total_film_copies using query from previous step
Create view total_film_copies AS
SELECT film.film_id, count(inventory.film_id) as total_copies FROM film 
join inventory ON film.film_id = inventory.film_id GROUP BY film_id;

-- write a SQL query that combines the data from the film table, the total_rental_amount view,
	-- and the total_film_copies view to find all films with a total rental amount greater than 
	-- 200.00 and display the following columns: film_id,title,description, rental_duration
	-- rental_rate, replacement_cost, rating, total_copies, total_amount
	
Select film.film_id,title,description,rental_duration,rental_rate,replacement_cost,rating,
	total_film_copies.total_copies, total_rental_amount.total_amount from film
	join total_film_copies on film.film_id = total_film_copies.film_id
	join total_rental_amount on film.film_id = total_rental_amount.film_id 
	where total_amount > 200.00 Group by film_id;
