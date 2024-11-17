with
    source as (
        select
            cast(productid as int) as productid
            , cast(productsubcategoryid as int) as productsubcategoryid
            , name as product_name
            , color as productcolor
            , standardcost
            , listprice 
            , case
                when productline = 'R' then 'Road'
                when productline = 'M' then 'Mountain'
                when productline = 'T' then 'Touring'
                when productline = 'S' then 'Standard'
                else null
                end as productline
            , case
                when style = 'W' then 'Womens'
                when style = 'M' then 'Mens'
                when style = 'U' then 'Universal'
                else null
                end as style
        from {{ source('sap_adw', 'product') }}
    )

select *
from source
