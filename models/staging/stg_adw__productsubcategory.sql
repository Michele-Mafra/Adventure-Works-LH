with source as (
    select
        productsubcategoryid as subcategory_id,
        name as subcategory_name
    from {{ source('sap_adw', 'productsubcategory') }}
)

select * from source
