with customers as (
    select * from {{ ref('dim_customers') }}

)

select
    customer_id

from customers
where number_of_orders > 0
AND ( first_order_date IS NULL OR most_recent_order_date IS NULL)