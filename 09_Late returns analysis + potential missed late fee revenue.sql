WITH return_stats AS (
SELECT  r.rental_id,
		r.return_date,
        r.rental_date + (f.rental_duration || 'days')::interval as due_date,
		GREATEST(
        EXTRACT(DAY FROM (r.return_date - (r.rental_date + (f.rental_duration || ' days')::interval))),
            0) AS days_late
FROM rental r
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE r.return_date IS NOT NULL
),
part2_stats AS (
SELECT
		COUNT(*) AS rental_count,
		COUNT( CASE WHEN days_late > 0 THEN 1 END) as total_late_returns,
		sum(days_late) as total_late_days,
		sum(days_late)* 1.00 as Total_late_fees_potential_miss
FROM return_stats
)
SELECT *,
    ROUND(100.0 * total_late_returns / rental_count, 2) || '%' AS percentage_of_total_rentals
FROM part2_stats
ORDER BY rental_count ;