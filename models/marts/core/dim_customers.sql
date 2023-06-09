with customers as (

    SELECT * FROM {{ ref('stg_customers') }}

),

orders as (

    SELECT * FROM {{ ref('stg_orders') }}

),

fct_orders as (

    SELECT * FROM {{ ref('fct_orders') }}

),

customer_orders as (

    select
        customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders

    from orders

    group by 1

),

customer_lifetime_value as (

    select
        customer_id,

        sum(amount) as lifetime_value

    from fct_orders

    group by 1

),


final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
        coalesce(customer_lifetime_value.lifetime_value, 0) as lifetime_value

    from customers

    left join customer_orders using (customer_id)
    left join customer_lifetime_value using (customer_id)

)

select * from final