with
    customers as (
        select
            sk_customer
            , customerid
        from {{ref('dim_customers')}} 
    )

    , creditcards as (
        select
            sk_creditcard
            , creditcardid
        from {{ref('dim_creditcards')}}
    )

    , locations as (
        select
            sk_shiptoaddress
            , shiptoaddressid
        from {{ref('dim_locations')}}
    )

    , products as (
        select
            sk_product
            , productid
        from {{ref('dim_products')}}
    )

    , dates as (
        select
            date
        from {{ref('dim_dates')}}
    )

    , reasons as (
        select
            salesorderid
            , reason_and_type
        from {{ref('dim_salesreasons')}}
    )

    , salesorderdetail as (
        select
            stg_salesorderdetail.salesorderid
            , products.sk_product as fk_product
            , stg_salesorderdetail.productid
            , stg_salesorderdetail.orderqty
            , stg_salesorderdetail.revenue
            , stg_salesorderdetail.unitprice
            , ifnull(reasons.reason_and_type,'Not indicated') as reason_and_type
        from {{ref('stg_sap__salesorderdetail')}} stg_salesorderdetail
        left join products on stg_salesorderdetail.productid = products.productid
        left join reasons on stg_salesorderdetail.salesorderid = reasons.salesorderid
    )

    , salesorderheader as (
        select
            salesorderid
            , customers.sk_customer as fk_customer
            , creditcards.sk_creditcard as fk_creditcard
            , locations.sk_shiptoaddress as fk_shiptoaddress
            , stg_salesorderheader.salespersonid 
            , order_status
            , order_date
        from {{ref('stg_sap__salesorderheader')}} stg_salesorderheader
        left join customers on stg_salesorderheader.customerid = customers.customerid
        left join creditcards on stg_salesorderheader.creditcardid = creditcards.creditcardid
        left join locations on stg_salesorderheader.shiptoaddressid = locations.shiptoaddressid
    )

    , final as (
        select
            salesorderdetail.salesorderid
            , salesorderdetail.fk_product
            , salesorderheader.fk_customer
            , salesorderheader.fk_shiptoaddress
            , salesorderheader.fk_creditcard
            , salesorderheader.salespersonid as fk_salesperson -- foreign key for salesperson
            , salesorderdetail.unitprice
            , salesorderdetail.orderqty
            , salesorderdetail.revenue -- Total value of the sale, including product discount, without taxes and freight
            , salesorderdetail.reason_and_type
            , salesorderheader.order_status
            , dates.date as order_date
        from salesorderdetail
        left join salesorderheader on salesorderdetail.salesorderid = salesorderheader.salesorderid
        left join dates on salesorderheader.order_date = dates.date 
    )

select *
from final
