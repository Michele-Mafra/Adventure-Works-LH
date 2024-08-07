with source as (
    select
        productcategoryid as category_id,
        name as category_name
    from {{ source('sap_adw', 'productcategory') }}
)

select * from source
