WITH int_sales_margin AS (
  SELECT
    s.orders_id,
    s.date_date,
    s.revenue,
    s.quantity,
    CAST(p.purchase_price AS FLOAT64) AS purchase_price,
    ROUND((s.quantity * CAST(p.purchase_price AS FLOAT64)), 2) AS purchase_cost,
    ROUND((s.revenue - (s.quantity * CAST(p.purchase_price AS FLOAT64))), 2) AS margin
  FROM {{ref("stg_raw__sales")}} s
  LEFT JOIN {{ref("stg_raw__product")}} p ON s.products_id = p.products_id
)

SELECT
  *
FROM (
  SELECT
    orders_id,
    MIN(date_date) AS date_date,
    MAX(date_date) AS max_date,
    SUM(margin) AS total_margin,
    SUM(purchase_price) AS total_purchase_cost,
    SUM(revenue) AS total_revenue,
    COUNT(DISTINCT products_id) AS distinct_products_count
  FROM {{ref("int_sales_margin")}}
  GROUP BY orders_id
  ORDER BY orders_id
) AS orders_margin