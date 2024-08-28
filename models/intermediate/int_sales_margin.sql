WITH calculated_values AS (
    SELECT 
        products_id, 
        date_date, 
        orders_id,
        revenue, 
        quantity, 
        CAST(purchase_price AS FLOAT64) AS purchase_price, 
        ROUND(s.quantity * CAST(p.purchase_price AS FLOAT64), 2) AS purchase_cost,
        s.revenue - ROUND(s.quantity * CAST(p.purchase_price AS FLOAT64), 2) AS margin
    FROM {{ ref("stg_raw__sales") }} s
    LEFT JOIN {{ ref("stg_raw__product") }} p 
        USING (products_id)
)

SELECT 
    products_id, 
    date_date, 
    orders_id,
    revenue, 
    quantity, 
    purchase_price,
    purchase_cost,
    margin,
    {{ margin_percent('revenue', 'purchase_cost') }} AS margin_percent
FROM calculated_values
