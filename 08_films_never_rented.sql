SELECT title from film f
LEFT JOIN inventory i
ON i.film_id = f.film_id
LEFT JOIN rental r
ON r.inventory_id = i.inventory_id
GROUP BY f.film_id, f.title
HAVING count(rental_id) = 0
ORDER BY title
