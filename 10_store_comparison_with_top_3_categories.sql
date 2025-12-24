WITH store_stats AS (
SELECT c.name,store.store_id as s_id,
	COUNT(*) as total_rentals_cat,
	SUM(p.amount) as total_rev_cat
from store
JOIN staff ON staff.store_id = store.store_id
JOIN rental r ON r.staff_id = staff.staff_id
JOIN payment p ON p.rental_id = r.rental_id
JOIN customer cu ON cu.customer_id = p.customer_id
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id
GROUP BY s_id, c.name
ORDER BY s_id
),
ranked AS (
    SELECT *,
ROW_NUMBER() OVER (PARTITION BY s_id ORDER BY total_rentals_cat DESC) AS rank_by_rentals,
ROW_NUMBER() OVER (PARTITION BY s_id ORDER BY total_rev_cat DESC) AS rank_by_revenue
FROM store_stats
),
store_customer as (
SELECT store.store_id,
SUM(p.amount) as total_revenue_per_store, 
COUNT(r.rental_id) as total_rentals,
COUNT(DISTINCT r.customer_id) as active_customers
FROM store
JOIN staff ON staff.store_id = store.store_id
JOIN rental r ON r.staff_id = staff.staff_id
JOIN payment p ON p.rental_id = r.rental_id
GROUP BY store.store_id
)
Select *
from store_customer
LEFT JOIN ranked ON ranked.s_id = store_customer.store_id
WHERE rank_by_rentals <= 3 OR rank_by_revenue <=3
ORDER BY s_id, total_rentals_cat DESC