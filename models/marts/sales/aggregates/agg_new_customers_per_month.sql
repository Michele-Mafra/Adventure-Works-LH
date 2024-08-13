with first_order as (
    select
        fk_customer,
        min(order_date) as first_order_date
    from {{ref('fact_sales')}}
    group by fk_customer
),
new_customers as (
    select
        c.sk_customer,
        c.name,
        extract(year from f.first_order_date) as year,
        extract(month from f.first_order_date) as month,
        count(distinct c.sk_customer) as new_customers
    from {{ref('dim_customers')}} c
    left join first_order f on c.sk_customer = f.fk_customer
    group by year, month
)

select
    year,
    month,
    new_customers
from new_customers
order by year, month
