with source as (
    select
        productid as product_id,
        name as product_name,
        productsubcategoryid as product_category_id
    from {{ source('sap_adw', 'product') }}
)

select * from source
