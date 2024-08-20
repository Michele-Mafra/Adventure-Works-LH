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
            productid as fk_product
            , product_name
            , listprice
            , productsubcategoryid as fk_productsubcategory
            , productline
            , style
        from {{ref('stg_sap__product')}}
    )

    , productsubcategory as (
        select
            productsubcategoryid as pk_productsubcategory
            , productcategoryid as fk_productcategory  -- Incluindo a foreign key para a categoria do produto
            , subcategory_name
        from {{ref('stg_sap__productsubcategory')}}
    )

    , productcategory as (
        select
            productcategoryid as pk_productcategory
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
        left join product on salesorderdetail.productid = product.fk_product
        left join productsubcategory on product.fk_productsubcategory = productsubcategory.pk_productsubcategory
        left join productcategory on productsubcategory.fk_productcategory = productcategory.pk_productcategory
    )

select *
from transformed
