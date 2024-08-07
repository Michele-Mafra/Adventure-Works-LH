with recursive date_cte as (
  select 
    date('2000-01-01') as date
  union all
  select
    date_add(date, interval 1 day)
  from
    date_cte
  where
    date < date('2020-12-31')
)

select
  date as date,
  extract(year from date) as year,
  extract(month from date) as month,
  extract(day from date) as day,
  extract(quarter from date) as quarter,
  format_date('%A', date) as weekday,
  format_date('%B', date) as month_name,
  case 
    when extract(dayofweek from date) in (1, 7) then true
    else false
  end as is_weekend
from
  date_cte