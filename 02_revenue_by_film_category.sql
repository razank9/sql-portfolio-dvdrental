SELECT ca.name as categories, 
		COUNT(ren.rental_id) AS rental_count,
		ROUND(sum(pay.amount),2) as total_revenue 
FROM category ca
JOIN film_category fc 
	ON fc.category_id = ca.category_id
JOIN film 
	ON film.film_id = fc.film_id
JOIN inventory inv 
	ON inv.film_id = film.film_id
JOIN rental ren 
	ON ren.inventory_id = inv.inventory_id
JOIN payment pay 
	ON pay.rental_id = ren.rental_id
GROUP BY ca.name
ORDER BY total_revenue DESC