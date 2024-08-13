with recent_orders as (
    select
        fk_customer,
        max(order_date) as last_order_date
    from {{ref('fact_sales')}}
    group by fk_customer
),
inactive_customers as (
    select
        c.sk_customer,
        c.name,
        r.last_order_date
    from {{ref('dim_customers')}} c
    left join recent_orders r on c.sk_customer = r.fk_customer
    where r.last_order_date < date_sub(current_date(), interval 6 month)
)

select
    sk_customer,
    name as customer_name,
    last_order_date
from inactive_customers
order by last_order_date desc
