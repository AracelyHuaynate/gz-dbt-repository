WITH source AS (
    SELECT * FROM {{source("raw","ship")}}
),
renamed AS (
SELECT
    orders_id
    shipping_fee
    shipping_fee_1
    logCost
    ship_cost
WHERE shipping_fee!=shipping_fee_1

FROM source

)
SELECT*FROM renamed