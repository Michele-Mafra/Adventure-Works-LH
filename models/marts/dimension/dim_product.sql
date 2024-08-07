with product as (
    select
        product_id,
        product_name,
        product_category_id
    from {{ ref('stg_adw__product') }}
),

subcategory as (
    select
        subcategory_id,
        subcategory_name
    from {{ ref('stg_adw__productsubcategory') }}
),

category as (
    select
        category_id,
        category_name
    from {{ ref('stg_adw__category') }}
)

select
    p.product_id,
    p.product_name,
    p.product_category_id as subcategory_id,
    sc.subcategory_name,
    c.category_id,
    c.category_name
from product p
left join subcategory sc on p.product_category_id = sc.subcategory_id
left join category c on sc.subcategory_id = c.category_id
