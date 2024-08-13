with total_revenue as (
    select
        sum(revenue) as total_revenue
    from {{ref('fact_sales')}}
),
region_revenue as (
    select
        l.country_name,
        l.state_name,
        sum(f.revenue) as region_revenue
    from {{ref('fact_sales')}} f
    left join {{ref('dim_locations')}} l on f.fk_shiptoaddress = l.sk_shiptoaddress
    group by l.country_name, l.state_name
),
market_share as (
    select
        r.country_name,
        r.state_name,
        r.region_revenue,
        (r.region_revenue / t.total_revenue) * 100 as market_share_percentage
    from region_revenue r, total_revenue t
)

select
    country_name,
    state_name,
    region_revenue,
    market_share_percentage
from market_share
order by market_share_percentage desc

