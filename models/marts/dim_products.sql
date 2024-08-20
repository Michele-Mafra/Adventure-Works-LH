with 
    salesorderheader as (
        select *
        from {{ref('stg_sap__salesorderheader')}}
    )

    , salesorderdetail as (
        select 
            distinct(productid)
        from {{ref('stg_sap__salesorderdetail')}}
    )

    , product as (
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
            {{ surrogate_key('salesorderdetail.productid') }} as sk_product
            , salesorderdetail.productid
            , product.product_name
            , productcategory.category_name
            , productsubcategory.subcategory_name
            , product.style
            , product.listprice as price
        from salesorderdetail
        left join product on salesorderdetail.productid = product.productid
        left join productsubcategory on product.productsubcategoryid = productsubcategory.productsubcategoryid
        left join productcategory on productsubcategory.productcategoryid = productcategory.productcategoryid
    )

select *
from transformed
