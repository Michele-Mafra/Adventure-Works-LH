with customers as (
    select
        sk_customer
        , customerid
    from {{ref('dim_customers')}} 
),

creditcards as (
    select
        sk_creditcard
        , creditcardid
    from {{ref('dim_creditcards')}}
),

locations as (
    select
        sk_shiptoaddress
        , shiptoaddressid
    from {{ref('dim_locations')}}
),

products as (
    select
        sk_product
        , productid
    from {{ref('dim_products')}}
),

dates as (
    select
        date
    from {{ref('dim_dates')}}
),

reasons as (
    select
        salesorderid
        , reason_name
    from {{ref('dim_salesreasons')}}
),

salesorderdetail AS (
    select
        stg_salesorderdetail.salesorderid
        , products.sk_product AS fk_product
        , stg_salesorderdetail.productid
        , stg_salesorderdetail.orderqty
        , stg_salesorderdetail.revenue
        , stg_salesorderdetail.unitprice
        , ifnull(reasons.reason_name,'Not indicated') as reason_name
    from {{ref('stg_sap__salesorderdetail')}} stg_salesorderdetail
    left join products ON stg_salesorderdetail.productid = products.productid
    left join reasons on stg_salesorderdetail.salesorderid = reasons.salesorderid
),

salesorderheader AS (
    select
        salesorderid
        , customers.sk_customer AS fk_customer
        , creditcards.sk_creditcard AS fk_creditcard
        , locations.sk_shiptoaddress AS fk_shiptoaddress
        , stg_salesorderheader.salespersonid -- Supondo que essa seja a chave para relacionar com o vendedor
        , order_status
        , order_date
    from {{ref('stg_sap__salesorderheader')}} stg_salesorderheader
    left join customers ON stg_salesorderheader.customerid = customers.customerid
    left join creditcards ON stg_salesorderheader.creditcardid = creditcards.creditcardid
    left join locations ON stg_salesorderheader.shiptoaddressid = locations.shiptoaddressid
),

final AS (
    select
        salesorderdetail.salesorderid
        , salesorderdetail.fk_product
        , salesorderheader.fk_customer
        , salesorderheader.fk_shiptoaddress
        , salesorderheader.fk_creditcard
        , salesorderheader.salespersonid AS fk_salesperson -- foreign key for salesperson
        , salesorderdetail.unitprice
        , salesorderdetail.orderqty
        , salesorderdetail.revenue -- Total value of the sale, including product discount, without taxes and freight
        , salesorderdetail.reason_name
        , salesorderheader.order_status
        , dates.date as order_date
    from salesorderdetail
    left join salesorderheader ON salesorderdetail.salesorderid = salesorderheader.salesorderid
    left join dates ON salesorderheader.order_date = dates.date 
)

select *
from final