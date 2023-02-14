-- -- 使用宏返回支付
-- {% macro get_payment_methods() %}
-- {{ return(["bank_transfer", "credit_card", "gift_card"]) }}
-- {%  endmacro %}


-- 动态检索支付, run_query
-- 第一次使用log()来进行调试
-- f3 模块化, from db or from param


{% macro get_column_values_demo(column_name, relation) %}
{% set relation_query %}
select distinct 
{{ column_name }}
from {{ relation }}
order by 1 
{% endset %}


{% set results = run_query(relation_query) %}
-- table -> list 

{% if execute %} -- 确保代码在 parse dbt 阶段运行
{% set results_list = results.columns[0].values() %}
{% else %}
{% set results_list=[] %}
{% endif %}

{{ log(results_list, info=False) }}

{{ return(results_list) }}

{%  endmacro %}


{% macro get_payment_methods_demo() %}
{{ return(get_column_values_demo('payment_method', ref('raw_payments'))) }}
{% endmacro %}



-- from dbt-utils包






