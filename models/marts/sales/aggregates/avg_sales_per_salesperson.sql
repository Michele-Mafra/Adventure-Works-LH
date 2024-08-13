with salesperson_info as (
    select
        s.businessentityid as salesperson_id,
        s.salesquota,
        s.bonus,
        s.commissionpct,
        s.salesytd,
        s.saleslastyear
    from {{ref('stg_sap__salesperson')}} s
),

avg_sales_salesperson as (
    select
        sp.salesperson_id,
        avg(f.revenue) as avg_sales_by_salesperson
    from {{ref('fact_sales')}} f
    left join salesperson_info sp on f.fk_customer = sp.salesperson_id
    where sp.salesperson_id is not null
    group by sp.salesperson_id
)

select
    salesperson_id,
    avg_sales_by_salesperson
from avg_sales_salesperson
order by avg_sales_by_salesperson desc

