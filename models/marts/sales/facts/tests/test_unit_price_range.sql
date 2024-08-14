with unitprice_check as (
    select *
    from {{ ref('fact_sales') }}
    where unitprice < 0
)
select
    count(*) as invalid_unitprices
from
    unitprice_check
