with source as (
    select
        productsubcategoryid
        , productcategoryid 
        , name as subcategory_name
    from {{ source('sap_adw', 'productsubcategory') }}
)

select * from source
