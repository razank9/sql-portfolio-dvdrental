SELECT 
    c.customer_id AS c_id,
    (first_name || ' ' || last_name) AS customer_name,
    ROUND(SUM(amount), 2) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY 
    c_id,
    customer_name
ORDER BY total_spent DESC
LIMIT 10;