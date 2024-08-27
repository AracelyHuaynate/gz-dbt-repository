with 

source as (

    select * from {{ source('raw', 'product') }}

),

renamed as (

    select
    pdt_id AS products_id
    purchSE_PRICE AS purchase_price

    from source

)

select * from renamed
