WITH sales_margin AS (
    -- Refiere al modelo int_sales_margin
    SELECT *
    FROM {{ ref("int_sales_margin") }}
),
shipping_info AS (
    -- Refiere al modelo que contiene los datos de shipping y costos logísticos
    SELECT
        orders_id,
        shipping_fee,
        CAST(ship_cost AS NUMERIC) AS ship_cost,
        logCost AS log_cost
    FROM {{ ref("stg_raw__ship") }}
)

SELECT
    sm.orders_id,
    sm.date_date,
    sm.total_margin,
    sm.total_purchase_cost,
    sm.total_revenue,
    si.shipping_fee,
    si.ship_cost,
    si.log_cost,
    -- Calcula el margen operativo
    ROUND((sm.total_margin + si.shipping_fee - si.ship_cost - si.log_cost), 2) AS operational_margin
FROM sales_margin sm
LEFT JOIN shipping_info si
ON sm.orders_id = si.orders_id
ORDER BY sm.orders_id;
