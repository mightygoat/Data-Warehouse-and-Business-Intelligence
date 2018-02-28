Select sum(amount), country , city from 
payment inner join customer
on payment.customer_id = customer.customer_id
inner join address
on address.address_id = customer.address_id
inner join city
on address.city_id = city.city_id
inner join country
on country.country_id = city.country_id
group by country, city;

Select title, sum(amount), rating, rental_rate, replacement_cost , name as categoryName from 
payment inner join rental
on payment.rental_id = rental.rental_id
inner join inventory
on inventory.inventory_id = rental.inventory_id
inner join film
on inventory.film_id = film.film_id
inner join film_category
on film.film_id = film_category.film_id
inner join category
on film_category.category_id = category.category_id
where rating = 'NC-17'
group by title;


Select name as categoryName, sum(amount) from 
payment inner join rental
on payment.rental_id = rental.rental_id
inner join inventory
on inventory.inventory_id = rental.inventory_id
inner join film
on inventory.film_id = film.film_id
inner join film_category
on film.film_id = film_category.film_id
inner join category
on film_category.category_id = category.category_id
where rental_rate= 2.99
group by name;


Select last_name , first_name, sum(amount), active, country , city from 
payment inner join customer
on payment.customer_id = customer.customer_id
inner join address
on address.address_id = customer.address_id
inner join city
on address.city_id = city.city_id
inner join country
on country.country_id = city.country_id
where country = 'China'
and active = 1
group by country, city;


