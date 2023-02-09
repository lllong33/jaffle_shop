with customers as (

    select * from {{ ref('stg_customers') }}

),

orders as (

    select * from {{ ref('stg_orders') }}

),

payments as (

    select * from {{ ref('stg_payments') }}

),

addr as (
    select * from {{ ref('stg_addr') }}
),

customer_orders as (

        select
        customer_id,

        min(order_date) as first_order,
        max(order_date) as most_recent_order,
        count(order_id) as number_of_orders
    from orders

    group by customer_id

),

customer_payments as (

    select
        orders.customer_id,
        sum(amount) as total_amount

    from payments

    left join orders on
         payments.order_id = orders.order_id

    group by orders.customer_id

),

final as (

    select
        t1.customer_id,
        t1.first_name,
        t1.last_name,
        customer_orders.first_order,
        customer_orders.most_recent_order,
        customer_orders.number_of_orders,
        customer_payments.total_amount as customer_lifetime_value
        ,t4.addr_id
        ,t4.tel
        ,t4.delivery_address
    from customers t1 

    left join customer_orders
        on t1.customer_id = customer_orders.customer_id

    left join customer_payments
        on  t1.customer_id = customer_payments.customer_id

    left join addr t4
        on t1.customer_id=t4.customer_id

)

select * from final
