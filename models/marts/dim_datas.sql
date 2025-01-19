with 
    generated_dates as (
        select
            date as dia
        from unnest(generate_date_array(
            cast('2008-01-01' as date),
            cast('2025-12-30' as date),
            interval 1 day
        )) as date
    )

    , exploded_dates as (
        select
            dia
            , extract(year from dia) as year
            , extract(month from dia) as month
            , extract(day from dia) as day
            , extract(dayofweek from dia) as day_of_week
            , extract(week from dia) as week
            , extract(quarter from dia) as quarter
        from generated_dates
    )

    , final as (
        select 
            {{ dbt_utils.generate_surrogate_key(['dia', 'year']) }} as sk_data,
            dia,
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
