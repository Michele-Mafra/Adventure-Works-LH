with sales_data as (
    select
        fk_product,
        count(distinct salesorderid) as total_orders,
        sum(revenue) as total_sales,
        sum(orderqty) as total_quantity_sold,
        avg(unitprice) as average_unit_price
    from {{ ref('fact_sales') }}
    group by fk_product
)
select
    p.sk_product,
    p.product_name,
    p.category_name,
    p.subcategory_name,
    s.total_sales,
    s.total_orders,
    s.total_quantity_sold,
    s.average_unit_price
from sales_data s
join {{ ref('dim_products') }} p on s.fk_product = p.sk_product
order by sk_product 
