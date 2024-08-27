WITH source AS (
    SELECT * FROM {{source("raw","product")}}
),
renamed AS (
SELECT
    products_id,
    purchSE_PRICE AS purchase_price

FROM source

)
SELECT*FROM renamed