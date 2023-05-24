with orders as (

    SELECT * FROM {{ ref('stg_orders') }}

),

payments as (

    SELECT * FROM {{ ref('stg_payments') }}

)

SELECT order_id, customer_id, sum(amount) as amount 
FROM payments pay 
join orders ord on pay.orderid = ord.order_id 
WHERE pay.status = 'success'
group by order_id, customer_id