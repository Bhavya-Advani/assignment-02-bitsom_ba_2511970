##Q1: Total sales revenue by product category for each month
SELECT 
    d.year,
    d.month_name,
    p.category,
    SUM(f.total_revenue) AS total_monthly_category_revenue
FROM fact_sales f
JOIN dim_date d ON f.date_id = d.date_id
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY d.year, d.month, d.month_name, p.category
ORDER BY d.year, d.month;

##Q2: Top 2 performing stores by total revenue
SELECT 
    s.store_name, 
    s.city, 
    SUM(f.total_revenue) AS store_total_revenue
FROM fact_sales f
JOIN dim_store s ON f.store_id = s.store_id
GROUP BY s.store_id, s.store_name, s.city
ORDER BY store_total_revenue DESC
LIMIT 2;

##Q3: Month-over-month sales trend across all stores
SELECT 
    d.month_name,
    SUM(f.total_revenue) AS current_month_revenue,
    LAG(SUM(f.total_revenue)) OVER (ORDER BY d.year, d.month) AS previous_month_revenue,
    ROUND(((SUM(f.total_revenue) - LAG(SUM(f.total_revenue)) OVER (ORDER BY d.year, d.month)) / 
    LAG(SUM(f.total_revenue)) OVER (ORDER BY d.year, d.month)) * 100, 2) AS mom_growth_percentage
FROM fact_sales f
JOIN dim_date d ON f.date_id = d.date_id
GROUP BY d.year, d.month, d.month_name
ORDER BY d.year, d.month;
