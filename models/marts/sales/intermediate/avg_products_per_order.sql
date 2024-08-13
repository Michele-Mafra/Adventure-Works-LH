select
    pk_orderdetail,
    cast(avg(orderqty) as integer) avg_products_per_order
from 
    {{ ref('stg_sap__salesorderdetail') }}
group by 
    pk_orderdetail
