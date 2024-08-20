with salesperson_data as (
    select
        fk_salesperson,
        extract(year from order_date) as order_year,
        count(distinct salesorderid) as total_orders,
        sum(revenue) as total_sales,
        avg(revenue) as average_sales_per_order
    from {{ ref('fact_sales') }}
    where fk_salesperson is not null
    group by fk_salesperson, order_year
)

select
    s.salesperson_id,
    sd.order_year,
    sd.total_sales,
    sd.total_orders,
    sd.average_sales_per_order
from salesperson_data sd
join {{ ref('stg_sap__salesperson') }} s on sd.fk_salesperson = s.salesperson_id
order by sd.order_year, sd.total_sales desc
