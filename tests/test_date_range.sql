select 
    fs.order_date, 
    count(*) as occurrences
from 
    {{ ref('fact_sales') }} fs
left join 
    {{ ref('dim_dates') }} dd
on 
    fs.order_date = dd.date
where 
    dd.date is null
group by 
    fs.order_date
order by 
    fs.order_date

