with
    stg_salesorderheader as (
        select *
        from {{ ref('stg_sap__salesorderheader') }}
    )
    , stg_salesorderdetail as (
        select *
        from {{ ref('stg_sap__salesorderdetail') }}
    )
    , stg_store as (
        select *
        from {{ ref('stg_sap__store') }}
    )
    , stg_businessentityaddress as (
        select *
        from {{ ref('stg_sap__businessentityaddress') }}
    )
    , dim_products as (
        select *
        from {{ ref('dim_products') }}
    )
    , stg_territory as (
        select *
        from {{ ref('stg_sap__salesterritory') }}
    )
    , agg_ds_sales as (
        select
            stg_salesorderdetail.salesorderdetailid
            , stg_salesorderheader.salesorderid
            , dim_products.productid
            , stg_salesorderheader.customerid
            , stg_store.businessentityid as storeid
            , dim_products.product_name
            , dim_products.subcategory_name
            , stg_territory.region
            , stg_store.store_name
            , stg_salesorderheader.order_date
            , stg_salesorderdetail.orderqty
        from stg_salesorderdetail
        left join stg_salesorderheader on stg_salesorderdetail.salesorderid = stg_salesorderheader.salesorderid
        left join stg_businessentityaddress on stg_salesorderheader.shiptoaddressid = stg_businessentityaddress.addressid
        left join stg_store on stg_businessentityaddress.businessentityid = stg_store.businessentityid
        left join dim_products on stg_salesorderdetail.productid = dim_products.productid
        left join stg_territory on stg_salesorderheader.territoryid = stg_territory.territoryid
    )
select *
from agg_ds_sales
