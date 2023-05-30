with payments as (
    SELECT * FROM {{ ref('stg_payments') }}
),

pivot as (
    SELECT orderid,
    SUM(case when paymentmethod = 'credit_card' then amount else 0 end) as credit_card_amount,
    SUM(case when paymentmethod = 'coupon' then amount else 0 end) as coupon_amount,
    SUM(case when paymentmethod = 'bank_transfer' then amount else 0 end) as bank_transfer_amount,
    SUM(case when paymentmethod = 'gift_card' then amount else 0 end) as gift_card_amount
    FROM payments
    WHERE status = 'success'
    GROUP BY orderid
)

SELECT * FROM pivot