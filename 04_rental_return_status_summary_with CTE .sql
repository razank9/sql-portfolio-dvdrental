WITH return_stats AS (
    SELECT 
        CASE
            WHEN r.return_date IS NULL THEN 'Not Returned'
            WHEN r.return_date < (r.rental_date + INTERVAL '1 day' * f.rental_duration) THEN 'Early'
            WHEN r.return_date > (r.rental_date + INTERVAL '1 day' * f.rental_duration) THEN 'Late'
            ELSE 'On Time'
        END AS return_status,
        COUNT(*) AS rental_count
    FROM rental r
    JOIN inventory i ON i.inventory_id = r.inventory_id
    JOIN film f ON i.film_id = f.film_id
    GROUP BY return_status
)
SELECT 
    return_status,
    rental_count,
    ROUND(100.0 * rental_count / (SELECT SUM(rental_count) FROM return_stats), 2) || '%' AS percentage
FROM return_stats
ORDER BY rental_count DESC;