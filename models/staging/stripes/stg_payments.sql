with payments as (

    select
        id as payment_id,
        orderid,
        paymentmethod,
        status, 
        {{ cents_to_dollars('amount') }},
        created

    from {{ source('stripe', 'payment') }}

)

SELECT * FROM payments