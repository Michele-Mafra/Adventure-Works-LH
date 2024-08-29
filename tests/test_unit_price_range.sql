select
    count(*) as invalid_unitprices
from
    {{ ref('fact_sales') }}
where
    unitprice < 0
having
    count(*) > 0
