{{
    config(
        materialized = 'incremental',
        unique_key = 'date_day',
    )
}}

select 
    *,
    my_slow_function(my_column)
    -- TODO 这里macro? table data
from raw_app_data.events

{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    where event_date > (select max(event_date) from {{ this }})
{% endif %}



