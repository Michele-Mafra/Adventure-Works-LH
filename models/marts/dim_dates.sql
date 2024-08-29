with
    date_range as (
        select
            generate_date_array(
                date('2011-05-01') -- Início de um range amplo
                , date('2014-06-30')  -- Fim de um range amplo
        ) as dates
    )

    , exploded_dates as (
        select
            date as date
        from date_range, unnest(dates) as date
    )

    select
        date
        , extract(year from date) as year
        , extract(month from date) as month
        , extract(day from date) as day
        , format_date('%B', date) as month_name
        , format_date('%A', date) as day_name
        , extract(quarter from date) as quarter
    from exploded_dates
