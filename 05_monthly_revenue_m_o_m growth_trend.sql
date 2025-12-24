WITH monthly_payments AS (
    SELECT 
        DATE_TRUNC('month', payment_date)::DATE AS month,
        COUNT(payment_id) AS payment_count,
        ROUND(SUM(amount), 2) AS monthly_revenue
    FROM payment
    GROUP BY month
)
SELECT 
    month,
    payment_count,
    monthly_revenue,
    LAG(monthly_revenue) OVER (ORDER BY month) AS prev_month_revenue,
    ROUND(monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY month), 2) AS revenue_change,
    ROUND(
        100.0 * (monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY month)) 
        / NULLIF(LAG(monthly_revenue) OVER (ORDER BY month), 0),
        2
    ) || '%' AS m_growth_percentage
FROM monthly_payments
ORDER BY month;