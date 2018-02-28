use sakila;

/*1- List films by rental amount, rating, rental rate, replacement cost, and category name with replacement cost less than $20*/
select title as Film, sum(amount) as RentalAmount, film.rating, rental_rate, replacement_cost, category.name as Category
from film
join inventory
on inventory.film_id=film.film_id
join rental
on inventory.inventory_id=rental.inventory_id
join payment
on rental.rental_id=payment.rental_id
join film_category
on film.film_id=film_category.film_id
join category
on category.category_id=film_category.category_id
where replacement_cost<20
group by film.film_id



/*2- top 10 countries by rental amount*/
select country, sum(amount)
from country
join city
on city.country_id=country.country_id
join address
on address.city_id=city.city_id
join customer
on customer.address_id=address.address_id
join rental
on rental.customer_id=customer.customer_id
join payment
on payment.rental_id=rental.rental_id
group by country
order by sum(amount) desc
limit 10


/*3- top 10 customers by rental amount for PG and PG-13 ratings*/
select first_name, last_name, film.rating, sum(amount)
from customer
join rental
on rental.customer_id=customer.customer_id
join payment
on rental.rental_id=payment.rental_id
join inventory
on inventory.inventory_id=rental.inventory_id
join film
on film.film_id=inventory.film_id
where film.rating in ("PG", "PG-13")
group by customer.customer_id
limit 10




/*4- film categories by rental amount and rental quantity*/
select category.name, sum(amount)
from category
join film_category
on film_category.category_id=category.category_id
join film
on film.film_id=film_category.film_id
join inventory
on film.film_id=inventory.film_id
join rental
on inventory.inventory_id=rental.inventory_id
join payment
on rental.rental_id=payment.rental_id
group by category.name

