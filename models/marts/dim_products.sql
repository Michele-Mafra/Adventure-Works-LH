with

    product as (
        select
            productid 
            , product_name
            , listprice
            , productsubcategoryid 
            , productline
            , style
        from {{ref('stg_sap__product')}}
    )

    , productsubcategory as (
        select
            productsubcategoryid 
            , productcategoryid 
            , subcategory_name
        from {{ref('stg_sap__productsubcategory')}}
    )

    , productcategory as (
        select
            productcategoryid 
            , category_name
        from {{ref('stg_sap__productcategory')}}
    )

    , transformed as (
        select 
            {{ surrogate_key('product.productid') }} as sk_product
            , product.productid
            , product.product_name
            , productcategory.category_name
            , productsubcategory.subcategory_name
            , product.style
            , product.listprice as price
        from product
        left join productsubcategory on product.productsubcategoryid = productsubcategory.productsubcategoryid
        left join productcategory on productsubcategory.productcategoryid = productcategory.productcategoryid
    )

select *
from transformed
