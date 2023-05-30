{%- set paymentmethods = ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] -%}

with payments as (
    SELECT * FROM {{ ref('stg_payments') }}
),

pivot as (
    SELECT orderid,
    {% for paymethod in paymentmethods %}
    SUM(case when paymentmethod = '{{ paymethod }}' then amount else 0 end) as {{ paymethod }}_amount{% if not loop.last %}, {% endif %}
    {%- endfor %}
    FROM payments
    WHERE status = 'success'
    GROUP BY orderid
)

SELECT * FROM pivot