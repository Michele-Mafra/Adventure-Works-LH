with
    sales_data as (
        select
            fk_shiptoaddress
            , count(distinct salesorderid) as total_orders
            , sum(revenue) as total_sales
            , avg(revenue) as average_sales_per_order
            , count(distinct fk_customer) as total_customers
        from {{ ref('fact_sales') }}
        group by fk_shiptoaddress
    )

        select
            l.country_name
            , l.state_name
            , l.city_name
            , sd.total_sales
            , sd.total_orders
            , sd.average_sales_per_order
            , sd.total_customers
        from sales_data sd
        join {{ ref('dim_locations') }} l on sd.fk_shiptoaddress = l.sk_shiptoaddress
