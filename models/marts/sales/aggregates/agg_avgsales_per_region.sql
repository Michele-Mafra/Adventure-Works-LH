with avg_sales_region as (
    select
        l.country_name,
        l.state_name,
        avg(f.revenue) as avg_sales_by_region
    from {{ref('fact_sales')}} f
    left join {{ref('dim_locations')}} l on f.fk_shiptoaddress = l.sk_shiptoaddress
    group by l.country_name, l.state_name
)

select
    country_name,
    state_name,
    avg_sales_by_region
from avg_sales_region
order by avg_sales_by_region desc

