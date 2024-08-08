select
    order_id,
    avg(total) as avg_ticket
from 
    {{ ref('stg_adw__salesorderheader') }}
group by 
    order_id
