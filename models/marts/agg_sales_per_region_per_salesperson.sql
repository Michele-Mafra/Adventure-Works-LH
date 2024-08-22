with
    sales_data as (
        select
            fk_shiptoaddress
            , fk_salesperson
            , extract(year from order_date) as order_year
            , sum(revenue) as total_sales
            , count(distinct salesorderid) as total_orders
            , avg(revenue) as average_sales_per_order
        from {{ ref('fact_sales') }}
        where fk_salesperson is not null
        group by fk_shiptoaddress, fk_salesperson, order_year
    )

    , region_sales as (
        select
            l.country_name
            , l.state_name
            , s.salesperson_id
            , sd.order_year
            , sum(sd.total_sales) as total_sales
            , sum(sd.total_orders) as total_orders
        from sales_data sd
        join {{ ref('dim_locations') }} l on sd.fk_shiptoaddress = l.sk_shiptoaddress
        join {{ ref('stg_sap__salesperson') }} s on sd.fk_salesperson = s.salesperson_id
        group by l.country_name, l.state_name, s.salesperson_id, sd.order_year
    )

    select
        country_name
        , state_name
        , salesperson_id
        , order_year
        , total_sales
        , total_orders
    from region_sales
    order by order_year, country_name, state_name, total_sales desc
    