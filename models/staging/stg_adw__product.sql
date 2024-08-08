with source as (
    select
        productid as product_id
        , name as product_name
        , safetystocklevel
        , productnumber
        , productmodelid
        , standardcost
        , listprice
        , daystomanufacture
        , productline
        , color
        , sellstartdate
        , productsubcategoryid as product_subcategory_id
        , 
    from {{ source('sap_adw', 'product') }}
)

select *
from source
