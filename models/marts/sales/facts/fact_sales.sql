with customers as (
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

, reasons as (
    select
        salesorderid
        , reason
    from {{ref('dim_salesreasons')}}
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

, salesorderdetail AS (
    SELECT
        stg_salesorderdetail.salesorderid
        , products.sk_product AS fk_product
        , stg_salesorderdetail.productid
        , stg_salesorderdetail.orderqty
        , stg_salesorderdetail.unitprice
        , stg_salesorderdetail.subtotal AS revenue
        , IFNULL(reasons.reason, 'Not indicated') AS reason_name
    FROM {{ref('stg_sap__salesorderdetail')}} stg_salesorderdetail
    LEFT JOIN products ON stg_salesorderdetail.productid = products.productid
    LEFT JOIN reasons ON stg_salesorderdetail.salesorderid = reasons.salesorderid
)

, salesorderheader AS (
    SELECT
        salesorderid
        , customers.sk_customer AS fk_customer
        , creditcards.sk_creditcard AS fk_creditcard
        , locations.sk_shiptoaddress AS fk_shiptoaddress
        , order_status
        , order_date
    FROM {{ref('stg_sap__salesorderheader')}} stg_salesorderheader
    LEFT JOIN customers ON stg_salesorderheader.customerid = customers.customerid
    LEFT JOIN creditcards ON stg_salesorderheader.creditcardid = creditcards.creditcardid
    LEFT JOIN locations ON stg_salesorderheader.shiptoaddressid = locations.shiptoaddressid
)

, final AS (
    SELECT
        salesorderdetail.salesorderid
        , salesorderdetail.fk_product
        , salesorderheader.fk_customer
        , salesorderheader.fk_shiptoaddress
        , salesorderheader.fk_creditcard
        , salesorderdetail.unitprice
        , salesorderdetail.orderqty
        , salesorderdetail.revenue -- total revenue including product discount, without tax and freight
        , salesorderdetail.reason_name
        , salesorderheader.order_status
        , dates.date as order_date
    FROM salesorderdetail
    LEFT JOIN salesorderheader ON salesorderdetail.salesorderid = salesorderheader.salesorderid
    LEFT JOIN dates ON salesorderheader.order_date = dates.date 
)

SELECT *
FROM final