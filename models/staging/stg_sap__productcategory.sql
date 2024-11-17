with
    source as (
        select
            cast(productcategoryid as int) as productcategoryid
            , name as category_name
        from {{ source('sap_adw', 'productcategory') }}
    )

select *
from source
