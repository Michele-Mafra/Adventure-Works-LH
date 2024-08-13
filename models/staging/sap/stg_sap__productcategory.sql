with source as (
    select
        productcategoryid 
        , case
            when productcategoryid = 1 then 'Bikes'
            when productcategoryid = 2 then 'Components'
            when productcategoryid = 3 then 'Clothing'
            when productcategoryid = 4 then 'Accessories'
            else null
        end as category_name 
    from {{ source('sap_adw', 'productcategory') }}
)

select * from source

