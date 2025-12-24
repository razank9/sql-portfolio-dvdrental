WITH stats AS (
SELECT c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        cat.name AS category_name,
		COUNT(*) as total_rentals_of_each_category,
		sum(p.amount) as total_spent_in_category
FROM customer c
    JOIN rental r ON c.customer_id = r.customer_id
    JOIN payment p ON r.rental_id = p.rental_id
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category cat ON fc.category_id = cat.category_id
    GROUP BY c.customer_id, c.first_name, c.last_name, cat.name
),

customer_with_totals AS(
SELECT customer_id,
        customer_name,
        category_name,
		total_rentals_of_each_category,
		SUM(total_rentals_of_each_category) OVER (partition by customer_id) as total_rentals_each_customer_across_all_category,
		total_spent_in_category,
		SUM(total_spent_in_category) OVER (partition by customer_id) as total_spent_by_customer
FROM stats
),
ranked AS(
SELECT *, 
DENSE_RANK() OVER(partition by customer_id ORDER BY total_spent_in_category DESC)as DRanking
FROM customer_with_totals 
)

SELECT 	customer_id AS c_id,
        customer_name,
		ROUND(total_spent_by_customer,2) AS life_time_value_customer,
		category_name AS fav_category,
		total_spent_in_category,
		total_rentals_of_each_category AS times_rented_fav, DRanking,
		ROUND((total_spent_in_category *100/ total_spent_by_customer ),1)|| '%' as Percentage_Fav_share
FROM ranked
where DRanking <= 5
ORDER BY total_spent_by_customer DESC,total_spent_in_category DESC
limit 100;