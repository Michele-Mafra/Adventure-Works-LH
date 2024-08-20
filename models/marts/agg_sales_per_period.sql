with sales_data as (
    select
        order_date,
        count(distinct salesorderid) as total_orders,
        sum(revenue) as total_sales,
        avg(revenue) as average_ticket,
        avg(orderqty) as average_items_per_order
    from {{ ref('fact_sales') }}
    group by order_date
)
select
    d.date,
    d.year,
    d.quarter,
    d.month,
    d.day,
    s.total_sales,
    s.total_orders,
    s.average_ticket,
    s.average_items_per_order
from sales_data s
join {{ ref('dim_dates') }} d on s.order_date = d.date
order by date 
