with date_range as (
    select
        generate_date_array(
            min(cast(order_date as DATE))
            , max(cast(order_date as DATE))
        ) as dates
    from {{ ref('stg_sap__salesorderheader') }}
),

exploded_dates as (
    select
        date as date
    from date_range, unnest(dates) as date
)

select
    row_number() over () as sk_date
    , date
    , extract(year from date) as year
    , extract(month from date) as month
    , extract(day from date) as day
    , format_date('%B', date) as month_name
    , format_date('%A', date) as day_name
    , extract(quarter from date) as quarter
    , extract(week from date) as week
    , extract(dayofweek from date) as day_of_week
from exploded_dates






