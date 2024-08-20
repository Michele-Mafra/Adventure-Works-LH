with
    source as (
        select
            cast(salesorderdetailid as int) as salesorderdetailid 
            , cast(salesorderid as int) as salesorderid 
            , cast(productid as int) as productid
            , cast(orderqty as int) as orderqty 
            , cast(unitprice as numeric) as unitprice 
            , cast(unitpricediscount as numeric) as discount
            , (unitprice * (1 - unitpricediscount) * orderqty) as revenue
        from {{ source('sap_adw', 'salesorderdetail') }}
    )

select *
from source
