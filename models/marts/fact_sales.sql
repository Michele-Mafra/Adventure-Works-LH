with
    customers as (
        select
            sk_customer as fk_customer
            , customerid
        from {{ref('dim_customers')}} 
    )

    , creditcards as (
        select
            sk_creditcard as fk_creditcard
            , creditcardid
        from {{ref('dim_creditcards')}}
    )

    , locations as (
        select
            sk_shiptoaddress as fk_shiptoaddress
            , shiptoaddressid
        from {{ref('dim_locations')}}
    )

    , products as (
        select
            sk_product as fk_product
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
            sk_salesreason as fk_salesreason
            , salesorderid
            , row_number() over (
                partition by
                    salesorderid
                    , salesreasonid
                order by salesreasonid desc
            ) as dedup_tabela
        from {{ref('dim_salesreasons')}}
    )

    /* for each orderid we can have more than one reason for the sale. The dedup was included to create the surrogate key for the fact table from the salesorderid */ 
    
    , dedup as (  
        select *
        from reasons
        where dedup_tabela = 1
    )

    , salesorderdetail as (
        select *
        from {{ref('stg_sap__salesorderdetail')}} 
    )

    , salesorderheader as (
        select *
        from {{ref('stg_sap__salesorderheader')}} 
    )

    , final as (
        select
            {{ surrogate_key(
                'salesorderdetail.salesorderid'
            ) }} as sk_factsales -- Surrogate Key
            , products.fk_product
            , customers.fk_customer
            , locations.fk_shiptoaddress
            , creditcards.fk_creditcard
            , salesorderheader.salespersonid
            , dedup.fk_salesreason 
            , salesorderdetail.salesorderid
            , salesorderdetail.unitprice
            , salesorderdetail.orderqty
            , salesorderdetail.revenue -- Total value of the sale, including product discount, without taxes and freight
            , salesorderheader.order_status
            , dates.date as order_date
        from salesorderdetail
        left join salesorderheader on salesorderdetail.salesorderid = salesorderheader.salesorderid
        left join dates on salesorderheader.order_date = dates.date 
        left join products on salesorderdetail.productid = products.productid
        left join dedup on salesorderdetail.salesorderid = dedup.salesorderid
        left join customers on salesorderheader.customerid = customers.customerid
        left join creditcards on salesorderheader.creditcardid = creditcards.creditcardid
        left join locations on salesorderheader.shiptoaddressid = locations.shiptoaddressid
    )

select *
from final
