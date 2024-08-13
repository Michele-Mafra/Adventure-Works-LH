with product_sales as (
    select
        p.category_name,
        p.product_name,
        sum(f.orderqty) as total_quantity_sold
    from {{ref('fact_sales')}} f
    left join {{ref('dim_products')}} p on f.fk_product = p.sk_product
    group by p.category_name, p.product_name
)

select
    category_name,
    product_name,
    total_quantity_sold
from product_sales
order by total_quantity_sold desc

