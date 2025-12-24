WITH actor_cat_stats AS (
SELECT
    c.name AS category_name,
    a.first_name || ' ' || a.last_name AS actor_name,
    COUNT(r.rental_id) AS rentals,
    ROW_NUMBER() OVER (PARTITION BY c.name ORDER BY COUNT(r.rental_id) DESC) AS actor_rank_category
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name, a.actor_id, a.first_name, a.last_name
)
SELECT * FROM actor_cat_stats
where actor_rank_category <= 5
ORDER BY category_name, actor_rank_category;