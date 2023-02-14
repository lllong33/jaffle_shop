/*
-- select
-- order_id,
-- sum(case when payment_method = 'bank_transfer' then amount end) as bank_transfer_amount,
-- sum(case when payment_method = 'credit_card' then amount end) as credit_card_amount,
-- sum(case when payment_method = 'gift_card' then amount end) as gift_card_amount,
-- sum(amount) as total_amount
-- from {{ ref('raw_payments') }}
-- group by 1



-- select 
-- order_id, 
-- {% for payment_method in ["bank_transfer", "credit_card", "gift_card"] %}
-- sum(case when payment_method = '{{payment_method}}' then amount end) as {{payment_method}}_amount,
-- {% endfor %}
-- sum(amount) as total_amount
-- from {{ ref('raw_payments') }}
-- group by 1



-- usage macros; 函数缺失时返回一个字符串*/


{%- set payment_methods=get_payment_methods_demo() -%}

select 
order_id, 
{%- for payment_method in payment_methods %}
sum(case when payment_method = '{{payment_method}}' then amount end) as {{payment_method}}_amount,
{% endfor %}
sum(amount) as total_amount
from {{ ref('raw_payments') }}
group by 1



