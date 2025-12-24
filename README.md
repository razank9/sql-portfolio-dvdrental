# DVD Rental Database Analysis – My First SQL Portfolio Project

**Database**: PostgreSQL dvdrental sample database (from Jose Portilla's Udemy course – .tar file included)  
**Tools**: PostgreSQL, pgAdmin  
**Background**: Self-taught SQL learner building practical skills through real-world-style analysis.

This is my first serious SQL project. I used the dvdrental database to practice joins, CTEs, window functions, date calculations, and turning data into business insights.

## Queries (10 Total)

1. **`01_top_10_customers_by_total_spending.sql`**  
   Top 10 customers by total spend.

2. **`02_revenue_by_film_category.sql`**  
   Revenue breakdown by film category.

3. **`03_top_10_most_rented_films.sql`**  
   Most popular films by rental count.

4. **`04_rental_return_status_summary.sql`**  
   Early / on-time / late / not returned rentals.

5. **`05_monthly_revenue_with_mom_growth.sql`**  
   Monthly revenue with month-over-month growth %.

6. **`06_top_actors_by_rentals_per_category.sql`**  
   Top actors by rentals in each category.

7. **`07_customer_ltv_with_favorite_genre_volume_vs_revenue.sql`**  
   Customer lifetime value + favorite genre (by rentals vs revenue).

8. **`08_films_never_rented.sql`**  
   Films never rented (anti-join technique – all films rented in this data!).

9. **`09_late_returns_analysis_missed_revenue.sql`**  
   Late returns – ~41% late, ~$16,000+ potential missed late fees.

10. **`10_store_comparison_with_top_3_categories.sql`**  
    Store 1 vs Store 2: revenue, rentals, customers, top categories.

## How to Run
1. Download `dvdrental.tar` (included in repo).
2. Restore in PostgreSQL (pgAdmin → Restore, or `pg_restore`).
3. Open and run each `.sql` file.

## What I Learned
- Clean CTEs make complex logic readable
- Window functions (ROW_NUMBER, DENSE_RANK for ranking, LAG for growth calculations)
- Date intervals for accurate "days late"
- Turning numbers into business stories (e.g., missed revenue)

Thanks for checking out my work!  
Feedback welcome — always learning.

— [Rajan Karki]  
[LinkedIn](https://www.linkedin.com/in/rajan-karki-a787a9179/)
razankarki365@gmail.com
