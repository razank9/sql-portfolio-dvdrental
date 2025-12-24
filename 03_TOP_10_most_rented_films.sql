SELECT 	f.title, 
		release_year,
		count(*) AS times_rented 
FROM film f
JOIN inventory i
ON i.film_id = f.film_id
JOIN rental r
ON r.inventory_id = i.inventory_id
GROUP BY f.title, release_year
ORDER BY times_rented DESC
LIMIT 10;