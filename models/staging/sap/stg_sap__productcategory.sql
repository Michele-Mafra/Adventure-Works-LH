with source as (
    select
        productcategoryid 
        , name as category_name
    from {{ source('sap_adw', 'productcategory') }}
)

select * from source

