with
    person as (
        select *
        from {{ ref('stg_sap__person') }}
    )
    , salesperson as (
        select *
        from {{ ref('stg_sap__salesperson') }}
    )
    , fact_sales as (
        select
            salespersonid
            , count(distinct salesorderid) as orders_qty
            , sum(subtotal) as total_sales
            , avg(subtotal) as avg_ticket
            , min(order_date) as first_sale
            , max(order_date) as last_sale
        from {{ ref('fact_sales') }}
        group by salespersonid
    )

    , sales_2012 as (
        select
            salespersonid
            , sum(subtotal) as sales_2012
        from {{ ref('fact_sales') }}
        where extract(year from order_date) = 2012
        group by salespersonid
    )

    , sales_2013 as (
        select
            salespersonid
            , sum(subtotal) as sales_2013
        from {{ ref('fact_sales') }}
        where extract(year from order_date) = 2013
        group by salespersonid
    )
    , sales_2014 as (
        select
            salespersonid
            , sum(subtotal) as sales_2014
        from {{ ref('fact_sales') }}
        where extract(year from order_date) = 2014
        group by salespersonid
    )
    , agg_salesperson as (
        select
            salesperson.salesperson_id
            , person.name
            , salesperson.salesquota
            , salesperson.bonus
            , salesperson.commissionpct
            , sales_2012.sales_2012
            , sales_2013.sales_2013
            , sales_2014.sales_2014
            , fact_sales.total_sales
            , fact_sales.orders_qty
            , fact_sales.avg_ticket
            , fact_sales.first_sale
            , fact_sales.last_sale
        from salesperson
        left join person on salesperson.salesperson_id = person.businessentityid
        left join fact_sales on salesperson.salesperson_id = fact_sales.salespersonid
        left join sales_2014 on salesperson.salesperson_id = sales_2014.salespersonid
        left join sales_2013 on salesperson.salesperson_id = sales_2013.salespersonid 
        left join sales_2012 on salesperson.salesperson_id = sales_2012.salespersonid 
    )
select *
from agg_salesperson
