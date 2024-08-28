WITH finance_days AS (
    SELECT
        date_date,
        COUNT(orders_id) AS nb_transactions,
        ROUND(SUM(margin), 0) AS ads_margin,
        ROUND(AVG(revenue), 1) AS average_basket,
        ROUND(SUM(operational_margin), 0) AS operational_margin,
        ROUND(SUM(purchase_cost), 0) AS purchase_cost,
        ROUND(SUM(shipping_fee), 0) AS shipping_fee,
        ROUND(SUM(logCost), 0) AS ship_cost,
        SUM(quantity) AS quantity
    FROM {{ ref("int_orders_operational") }}
    GROUP BY date_date
),

int_campaigns_day AS (
    SELECT
        date_date,
        SUM(ads_cost) AS ads_cost,
        SUM(impression) AS ads_impressions,
        SUM(click) AS ads_clicks
    FROM {{ ref('int_campaigns') }}  -- Asegúrate de que el nombre de referencia es correcto
    GROUP BY date_date
)

SELECT
    f.date_date,
    f.nb_transactions,
    f.operational_margin,  -- Solo una referencia aquí
    f.average_basket,
    f.purchase_cost,
    f.shipping_fee,
    f.ship_cost,
    f.quantity,
    c.ads_cost,
    c.ads_impressions,
    c.ads_clicks,
    ROUND(f.operational_margin - c.ads_cost, 0) AS calculated_ads_margin 
FROM {{ ref("finance_days") }} AS f
LEFT JOIN {{ ref("int_campaigns_day") }} AS c
    ON f.date_date = c.date_date
ORDER BY f.date_date DESC


