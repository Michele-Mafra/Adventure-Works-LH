with
    salesregion as (
        select *
        , case  
            when country_code = 'US' then concat(region, ' , ', country_code)
            else region
            end as territory
        from {{ ref('stg_sap__salesterritory') }}
    )
    , fact_sales as (
        select
            territoryid
            , count(distinct salesorderid) as orders_qty
            , sum(subtotal) as total_sales
            , avg(subtotal) as avg_ticket
            , min(order_date) as first_sale
            , max(order_date) as last_sale
        from {{ ref('fact_sales') }}
        group by territoryid
    )

    , sales_2012 as (
        select
            territoryid
            , sum(subtotal) as subtotal_2012
        from {{ ref('fact_sales') }}
        where extract(year from order_date) = 2012
        group by territoryid
    )

    , sales_2013 as (
        select
            territoryid
            , sum(subtotal) as subtotal_2013
        from {{ ref('fact_sales') }}
        where extract(year from order_date) = 2013
        group by territoryid
    )
    , sales_2014 as (
        select
            territoryid
            , sum(subtotal) as subtotal_2014
        from {{ ref('fact_sales') }}
        where extract(year from order_date) = 2014
        group by territoryid
    )
    , agg_salesregion as (
        select
            salesregion.territory
            , fact_sales.territoryid
            , sales_2012.subtotal_2012
            , sales_2013.subtotal_2013
            , sales_2014.subtotal_2014
            , fact_sales.total_sales
            , fact_sales.orders_qty
            , fact_sales.avg_ticket
            , fact_sales.first_sale
            , fact_sales.last_sale
        from salesregion
        left join fact_sales on salesregion.territoryid = fact_sales.territoryid
        left join sales_2014 on salesregion.territoryid = sales_2014.territoryid
        left join sales_2013 on salesregion.territoryid = sales_2013.territoryid    
        left join sales_2012 on salesregion.territoryid = sales_2012.territoryid    
    )
select *
from agg_salesregion
