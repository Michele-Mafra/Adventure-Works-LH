with region_sales as (
    select
        l.country_name,
        l.state_name,
        count(f.salesorderid) as sales_count_by_region
    from {{ref('fact_sales')}} f
    left join {{ref('dim_locations')}} l on f.fk_shiptoaddress = l.sk_shiptoaddress
    group by l.country_name, l.state_name
)

select
    country_name,
    state_name,
    sales_count_by_region
from region_sales
order by sales_count_by_region desc
