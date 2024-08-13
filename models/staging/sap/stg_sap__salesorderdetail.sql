with source as (
    select
        salesorderdetailid 
        , salesorderid 
        , productid 
        , orderqty 
        , unitprice 
        , unitpricediscount 
        , (unitprice * (1 - unitpricediscount) * orderqty) as subtotal
    from {{ source('sap_adw', 'salesorderdetail') }}
)

select *
from source
