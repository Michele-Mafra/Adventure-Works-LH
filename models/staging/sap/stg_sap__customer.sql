with source as (
    select
    customerid 
    , personid 
    , storeid 
    from {{ source('sap_adw', 'customer') }}
)

select *
from source