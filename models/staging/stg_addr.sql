with source as (

    {#-
    Normally we would select from the table here, but we are using seeds to load
    our data in this project
    #}
    select * from {{ ref('raw_addr') }}

),

renamed as (

    select
        id as addr_id,
        user_id as customer_id,
        tel,
        delivery_address
    from source

)

select * from renamed
