with 
    generated_dates as (
        select
            date as sk_date
        from unnest(generate_date_array(
            cast('2008-01-01' as date),
            cast('2025-12-30' as date),
            interval 1 day
        )) as date
    )

    , exploded_dates as (
        select
            sk_date
            , extract(year from sk_date) as year
            , extract(month from sk_date) as month
            , extract(day from sk_date) as day
            , extract(dayofweek from sk_date) as day_of_week
            , extract(week from sk_date) as week
            , extract(quarter from sk_date) as quarter
        from generated_dates
    )

    , final as (
        select 
            sk_date,
            year,
            month,
            case 
                when month = 1 then 'Jan'
                when month = 2 then 'Fev'
                when month = 3 then 'Mar'
                when month = 4 then 'Abr'
                when month = 5 then 'Mai'
                when month = 6 then 'Jun'
                when month = 7 then 'Jul'
                when month = 8 then 'Ago'
                when month = 9 then 'Set'
                when month = 10 then 'Out'
                when month = 11 then 'Nov'
                when month = 12 then 'Dez'
            end as month_abbreviation,
            case 
                when day_of_week = 1 then 'Domingo'
                when day_of_week = 2 then 'Segunda-feira'
                when day_of_week = 3 then 'Terça-feira'
                when day_of_week = 4 then 'Quarta-feira'
                when day_of_week = 5 then 'Quinta-feira'
                when day_of_week = 6 then 'Sexta-feira'
                when day_of_week = 7 then 'Sábado'
            end as day_of_week_name,
            quarter
        from exploded_dates
    )
    select * from final
