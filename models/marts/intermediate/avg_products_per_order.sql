select
    order_id,
    cast(avg(order_qty) as integer) avg_products_per_sale
from 
    {{ ref('stg_adw__salesorderdetail') }}
group by 
    order_id
