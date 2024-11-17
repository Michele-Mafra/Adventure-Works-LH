with
    customers as (
        select
            sk_customer as fk_customer
            , customerid
        from {{ref('dim_customers')}} 
    ),

    creditcards as (
        select
            sk_creditcard as fk_creditcard
            , creditcardid
        from {{ref('dim_creditcards')}}
    ),

    locations as (
        select
            sk_shiptoaddress as fk_shiptoaddress
            , shiptoaddressid
        from {{ref('dim_locations')}}
    ),

    products as (
        select
            sk_product as fk_product
            , productid
        from {{ref('dim_products')}}
    ),

    dates as (
        select
            date
        from {{ref('dim_dates')}}
    ),

    aggregated_reasons as (
        select
            sk_salesreason as fk_salesreason
            , salesorderid
        from {{ ref('dim_salesreasons') }}
    ),

    salesorderdetail as (
        select *
        from {{ref('stg_sap__salesorderdetail')}} 
    ),

    salesorderheader as (
        select *
        from {{ref('stg_sap__salesorderheader')}} 
    ),

    final as (
        select
            {{ surrogate_key('salesorderdetail.salesorderdetailid') }} as sk_factsales
            , products.fk_product
            , customers.fk_customer
            , locations.fk_shiptoaddress
            , creditcards.fk_creditcard
            , aggregated_reasons.fk_salesreason
            , salesorderdetail.salesorderdetailid
            , salesorderheader.salespersonid
            , salesorderheader.salesorderid
            , salesorderheader.territoryid
            , salesorderdetail.unitprice
            , salesorderdetail.orderqty
            , salesorderdetail.subtotal
            , salesorderheader.order_status
            , salesorderheader.ordered_online
            , dates.date as order_date
        from salesorderdetail
        left join salesorderheader on salesorderdetail.salesorderid = salesorderheader.salesorderid
        left join dates on salesorderheader.order_date = dates.date 
        left join products on salesorderdetail.productid = products.productid
        left join aggregated_reasons on salesorderdetail.salesorderid = aggregated_reasons.salesorderid 
        left join customers on salesorderheader.customerid = customers.customerid
        left join creditcards on salesorderheader.creditcardid = creditcards.creditcardid
        left join locations on salesorderheader.shiptoaddressid = locations.shiptoaddressid
    )

select *
from final
