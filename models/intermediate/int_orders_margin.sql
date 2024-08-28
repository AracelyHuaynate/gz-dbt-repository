WITH sales_margin AS (
    -- Refiere al modelo anterior int_sales_margin
    SELECT *
    FROM {{ ref("int_sales_margin") }}
)

SELECT
    orders_id,
    date_date,
    SUM(margin) AS total_margin,
    SUM(purchase_cost) AS total_purchase_cost,
    SUM(revenue) AS total_revenue,
    COUNT(DISTINCT products_id) AS distinct_products_count
FROM sales_margin
GROUP BY orders_id, date_date
ORDER BY orders_id;
