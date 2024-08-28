WITH int_sales_margin AS (
    SELECT 
        s.orders_id,
        s.revenue,
        s.quantity,
        CAST(p.purchase_price AS FLOAT64) AS purchase_price,
        ROUND((s.quantity * CAST(p.purchase_price AS FLOAT64)), 2) AS purchase_cost,
        ROUND(s.revenue - (s.quantity * CAST(p.purchase_price AS FLOAT64)), 2) AS margin,
        h.shipping_fee,
        h.log_cost,
        h.ship_cost
    FROM {{ref("stg_raw__sales")}} s 
    LEFT JOIN {{ref("stg_raw__ship")}} h ON s.orders_id = h.orders_id
)

SELECT 
    orders_id,
    SUM(margin) AS total_margin,
    SUM(shipping_fee) AS total_shipping_fee,
    SUM(log_cost) AS total_log_cost,
    SUM(ship_cost) AS total_ship_cost,
    SUM(margin + shipping_fee - log_cost - ship_cost) AS total_operational_margin
FROM {{ref("int_sales_margin")}}
GROUP BY orders_id
ORDER BY orders_id